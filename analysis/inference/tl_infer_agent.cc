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
}

void tl_infer_agent_feed_input(tl_infer_agent_input_t* pInput) {
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

    // Copy the resized RGB data to the input tensor
    for (int i = 0; i < model_settings.kMaxImageSize; i += 3) {
        *(input + i) = ((float)pResizedRgbData[i] - 127.5f) / 127.5f;
        *(input + i + 1) = ((float)pResizedRgbData[i + 1] - 127.5f) / 127.5f;
        *(input + i + 2) = ((float)pResizedRgbData[i + 2] - 127.5f) / 127.5f;
        // Include mean normalization
        input[i] += TL_AGENT_INPUT_CHANNEL_RED_NORMALIZATION__MEAN;
        input[i + 1] += TL_AGENT_INPUT_CHANNEL_GREEN_NORMALIZATION__MEAN;
        input[i + 2] += TL_AGENT_INPUT_CHANNEL_BLUE_NORMALIZATION__MEAN;

        // Include standard deviation normalization
        input[i] *= TL_AGENT_INPUT_CHANNEL_RED_NORMALIZATION__STDEV;
        input[i + 1] *= TL_AGENT_INPUT_CHANNEL_GREEN_NORMALIZATION__STDEV;
        input[i + 2] *= TL_AGENT_INPUT_CHANNEL_BLUE_NORMALIZATION__STDEV;
    }

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
    float notify_score = output[model_settings.kNotifyIndex];
    float nop_score = output[model_settings.kNopIndex];

    // [TODO] @verify
    if (notify_score > nop_score) {
        return TL_INFER_AGENT_OUTPUT_TRIGGER_ACTION;
    } else {
        return TL_INFER_AGENT_OUTPUT_NO_ACTION;
    }
}
