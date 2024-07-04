#include "tl_infer_agent.h"

// #include "tensorflow/lite/micro/micro_mutable_op_resolver.h"
// #include "tensorflow/lite/micro/micro_interpreter.h"
// #include "tensorflow/lite/micro/system_setup.h"
// #include "tensorflow/lite/schema/schema_generated.h"

// #include "img_converters.h"

// #include "esp_log.h"

#include "tensorflow/lite/interpreter.h"
#include "tensorflow/lite/kernels/register.h"
#include "tensorflow/lite/model.h"
#include "tensorflow/lite/tools/gen_op_registration.h"

extern "C" {
    #include "converter.h"
}

namespace {
    std::unique_ptr<tflite::FlatBufferModel> model;
    std::unique_ptr<tflite::Interpreter> interpreter;
    float* input = nullptr;
    float* output = nullptr;
    int inference_count = 0;
}

struct __tl_infer_agent_model_settings {
    int kNumCols;
    int kNumRows;
    int kNumChannels;
    int kMaxImageSize;
    int kCategoryCount;
    int kNotifyIndex;
    int kNopIndex;
} model_settings;

void tl_infer_agent_init() {

    model_settings.kNumCols = TL_INFER_AGENT_NUM_COLS;
    model_settings.kNumRows = TL_INFER_AGENT_NUM_ROWS;
    model_settings.kNumChannels = TL_INFER_AGENT_NUM_CHANNELS;
    model_settings.kMaxImageSize = TL_INFER_AGENT_NUM_COLS * TL_INFER_AGENT_NUM_ROWS * TL_INFER_AGENT_NUM_CHANNELS;
    model_settings.kCategoryCount = TL_INFER_AGENT_CATEGORY_COUNT;
    model_settings.kNotifyIndex = TL_INFER_AGENT_NOTIFY_INDEX;
    model_settings.kNopIndex = TL_INFER_AGENT_NOP_INDEX;


    // Map the model into a usable data structure. This doesn't involve any
    // copying or parsing, it's a very lightweight operation.
    model = tflite::FlatBufferModel::BuildFromFile(TL_AGENT_MODEL_PATH);
    
    tflite::ops::builtin::BuiltinOpResolver resolver;
    tflite::InterpreterBuilder(*model.get(), resolver)(&interpreter);
    
    interpreter->AllocateTensors();

    // Obtain pointers to the model's input and output tensors.
    input = interpreter->typed_input_tensor<float>(0);
    output = interpreter->typed_output_tensor<float>(0);

    // Keep track of how many inferences we have performed.
    inference_count = 0;

    
    TfLiteTensor* pInputTensor = interpreter->input_tensor(0);

    TfLiteIntArray* dims = pInputTensor->dims;
    fprintf(stdout, "------------------\n");
    fprintf(stdout, "pInputTensor->type: %d\n", pInputTensor->type);
    fprintf(stdout, "pInputTensor->dims->size: %d\n", dims->size);
    for (int i = 0; i < dims->size; i++) {
        fprintf(stdout, "pInputTensor->dims->data[%d]: %d\n", i, dims->data[i]);
    }
    fprintf(stdout, "------------------\n");
}

void tl_infer_agent_feed_input(tl_infer_agent_input_t* pInput) {
    //fprintf(stdout, "IN tl_infer_agent_feed_input\n");
    //Perform conversion of JFIF image data to RGB
    uint8_t* pRgbData = NULL;
    uint32_t rgbDataLen = 0;
    uint32_t imageWidth = 0;
    uint32_t imageHeight = 0;

    converter_jfif2rgb(pInput->puData, 
                      pInput->len, 
                      &pRgbData, 
                      &rgbDataLen, 
                      &imageWidth, 
                      &imageHeight);

    // Convert image size to TF_INFER_AGENT_NUM_ROWS x TF_INFER_AGENT_NUM_COLS and feed it to the model
    uint8_t* pResizedRgbData = NULL;
    uint32_t resizedRgbDataLen = 0;
    
    converter_resize_skip_rgb(pRgbData, 
                              rgbDataLen, 
                              imageWidth,
                              imageHeight, 
                              model_settings.kNumCols, 
                              model_settings.kNumRows, 
                              &pResizedRgbData, 
                              &resizedRgbDataLen);
    
    free(pRgbData);

    uint8_t* pTraResRgbData = NULL;

    //converter_transpose_rgb(pResizedRgbData, imageWidth, imageHeight, &pTraResRgbData);
    converter_transpose_rgb(pResizedRgbData, model_settings.kNumCols, model_settings.kNumRows, &pTraResRgbData);

    free(pResizedRgbData);

    // Standardize the resized image data and feed it to the model
    // for (int i = 0; i < model_settings.kMaxImageSize - 2; i += 3) {
    //     input[i] = ((float)pResizedRgbData[i]) / 255.0f;
    //     input[i+1] = ((float)pResizedRgbData[i+1]) / 255.0f;
    //     input[i+2] = ((float)pResizedRgbData[i+2]) / 255.0f;


    //     // Include standardization
    //     input[i] -= TL_AGENT_INPUT_CHANNEL_RED_STANDARDIZATION__MEAN;
    //     input[i + 1] -= TL_AGENT_INPUT_CHANNEL_GREEN_STANDARDIZATION__MEAN;
    //     input[i + 2] -= TL_AGENT_INPUT_CHANNEL_BLUE_STANDARDIZATION__MEAN;

    //     input[i] /= TL_AGENT_INPUT_CHANNEL_RED_STANDARDIZATION__STDEV;
    //     input[i + 1] /= TL_AGENT_INPUT_CHANNEL_GREEN_STANDARDIZATION__STDEV;
    //     input[i + 2] /= TL_AGENT_INPUT_CHANNEL_BLUE_STANDARDIZATION__STDEV;
    // }

    int numPixels = model_settings.kMaxImageSize / model_settings.kNumChannels;
    for (int i = 0; i < numPixels; i++) {
        float* inputChannelR = input;
        float* inputChannelG = inputChannelR + numPixels;
        float* inputChannelB = inputChannelG + numPixels;

        uint8_t* traresChannelR = pTraResRgbData;
        uint8_t* traresChannelG = traresChannelR + numPixels;
        uint8_t* traresChannelB = traresChannelG + numPixels;

        inputChannelR[i] = ((float)traresChannelR[i]) / 255.0f;
        inputChannelG[i] = ((float)traresChannelG[i]) / 255.0f;
        inputChannelB[i] = ((float)traresChannelB[i]) / 255.0f;

        // Include standardization
        inputChannelR[i] -= TL_AGENT_INPUT_CHANNEL_RED_STANDARDIZATION__MEAN;
        inputChannelG[i] -= TL_AGENT_INPUT_CHANNEL_GREEN_STANDARDIZATION__MEAN;
        inputChannelB[i] -= TL_AGENT_INPUT_CHANNEL_BLUE_STANDARDIZATION__MEAN;

        inputChannelR[i] /= TL_AGENT_INPUT_CHANNEL_RED_STANDARDIZATION__STDEV;
        inputChannelG[i] /= TL_AGENT_INPUT_CHANNEL_GREEN_STANDARDIZATION__STDEV;
        inputChannelB[i] /= TL_AGENT_INPUT_CHANNEL_BLUE_STANDARDIZATION__STDEV;

    }

    free(pTraResRgbData);
}

void tl_infer_agent_perform_inference() {
    // Run the model on this input and make sure it succeeds.
    TfLiteStatus invoke_status = interpreter->Invoke();
    if (invoke_status != kTfLiteOk) {
        fprintf(stderr, "Error: interpreter->Invoke failed");
        //exit(EXIT_FAILURE);
    }
}

tl_infer_agent_output_t tl_infer_agent_get_output() {
    /*float notify_score = output[model_settings.kNotifyIndex];
    float nop_score = output[model_settings.kNopIndex];

    fprintf(stdout, "Notify score: %4.2f\n", notify_score);
    fprintf(stdout, "Nop score: %4.2f\n", nop_score); 

    if ( notify_score > nop_score ) {
    	return TL_INFER_AGENT_OUTPUT_TRIGGER_ACTION;
    } else {
    	return TL_INFER_AGENT_OUTPUT_NO_ACTION;
    }*/
    
    // Ensure the output tensor has enough elements
    int output_size = interpreter->tensor(interpreter->outputs()[0])->bytes / sizeof(float);

    if (model_settings.kNotifyIndex >= output_size || model_settings.kNopIndex >= output_size) {
        fprintf(stderr, "Error: Output indices out of range\n");
        exit(EXIT_FAILURE);
    }

    // Access the output values
    float notify_score = output[model_settings.kNotifyIndex];
    float nop_score = output[model_settings.kNopIndex];

    // Log the scores
    fprintf(stdout, "Notify score: %4.2f\n", notify_score);
    fprintf(stdout, "Nop score: %4.2f\n", nop_score); 

    // Compare scores and return appropriate action
    if (notify_score > nop_score) {
        return TL_INFER_AGENT_OUTPUT_TRIGGER_ACTION;
    } else {
        return TL_INFER_AGENT_OUTPUT_NO_ACTION;
    }

}
