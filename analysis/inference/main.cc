#include <stdio.h>
#include "tensorflow/lite/interpreter.h"
#include "tensorflow/lite/kernels/register.h"
#include "tensorflow/lite/model.h"
#include "tensorflow/lite/tools/gen_op_registration.h"

int main(){

    std::unique_ptr<tflite::FlatBufferModel> model = tflite::FlatBufferModel::BuildFromFile("surveillance_mobilenet_10_epochs_fixed_LS_90_balanced.tflite");

    if(!model){
        printf("Failed to mmap model\n");
        exit(0);
    }

    tflite::ops::builtin::BuiltinOpResolver resolver;
    std::unique_ptr<tflite::Interpreter> interpreter;
    tflite::InterpreterBuilder(*model.get(), resolver)(&interpreter);

    // Resize input tensors, if desired.
    interpreter->AllocateTensors();

    float* input = interpreter->typed_input_tensor<float>(0);
    // Dummy input for testing
    *input = 2.0;

    interpreter->Invoke();

    float* output = interpreter->typed_output_tensor<float>(0);

    printf("Result is: %f\n", *output);

    return 0;
}