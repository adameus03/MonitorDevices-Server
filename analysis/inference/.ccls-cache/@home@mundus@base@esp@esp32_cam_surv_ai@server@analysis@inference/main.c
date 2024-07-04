#include <stdio.h>
#include <semaphore.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <stdlib.h>
#include "tl_infer_agent.h"

#define SHM_KEY 0xfedcba98
// 4k -> 3480 x 216
// 3480 * 2160 * 2 = 16588800
#define MAX_JFIF_SZ 16588800 

typedef struct {
    sem_t toSauas_semph;
    sem_t fromSauas_semph;
    uint8_t output;
    uint64_t buf_sz;
    uint8_t buf[MAX_JFIF_SZ];
} sau_shm_t;

static int SHM_ID = -1;
static sau_shm_t* __sauas = NULL;

#define OPTLOG if(1)

void handle_sauas() {
    printf("[handle_sauas] Entered sauas-handling loop\n");
    while(1){
        OPTLOG printf("[handle_sauas] Waiting for sauas\n");
        sem_wait(&__sauas->fromSauas_semph);
        OPTLOG printf("[handle_sauas] Done waiting for sauas\n");

        tl_infer_agent_input_t input = {
            .puData = __sauas->buf,
            .len = __sauas->buf_sz
        };

        OPTLOG printf("[handle_sauas] Feeding input to the inference agent\n");
        tl_infer_agent_feed_input(&input);
        OPTLOG printf("[handle_sauas] Performing inference\n");
        tl_infer_agent_perform_inference();
        OPTLOG printf("[handle_sauas] Fetching output from the inference agent\n");
        tl_infer_agent_output_t output = tl_infer_agent_get_output();
        __sauas->output = output;
        OPTLOG printf("[handle_sauas] Inference output: %d\n", output);
        OPTLOG printf("[handle_sauas] Posting to sauas\n");
        sem_post(&__sauas->toSauas_semph);
    }

}

int main(){
    printf("[main] Initializing the inference agent\n");
    tl_infer_agent_init();
    printf("[main] Inference agent initialized\n");
    printf("Configuring shared memory\n");

    SHM_ID = shmget(SHM_KEY, sizeof(sau_shm_t), IPC_CREAT | 0777); // [TODO] Adjust permissions
    if (SHM_ID == -1){
        fprintf(stderr, "[main] Failed to create shared memory\n");
        exit(EXIT_FAILURE);
    }
    __sauas = (sau_shm_t*) shmat(SHM_ID, NULL, 0);
    if (!((int64_t)__sauas > 0)) {
        fprintf(stderr, "[main] Failed to attach to shared memory\n");
        exit(EXIT_FAILURE);
    }
    fprintf(stdout, "[main] Shared memory attached at %p\n", __sauas);

    if (-1 == sem_init(&__sauas->toSauas_semph, 1, 0)){
        fprintf(stderr, "[main] Failed to initialize __sauas->toSauas_semph\n");
        exit(EXIT_FAILURE);
    }
    fprintf(stdout, "[main] Initialized __sauas->toSauas_semph\n");
    if (-1 == sem_init(&__sauas->fromSauas_semph, 1, 0)){
        fprintf(stderr, "[main] Failed to initialize __sauas->fromSauas_semph\n");
        exit(EXIT_FAILURE);
    }
    fprintf(stdout, "[main] Initialized __sauas->fromSauas_semph\n");

    handle_sauas(); // Loop forever handling sauas

    return 0;
}

// #include <v8.h>
// #include <node.h>
// #include <node_buffer.h>

// using namespace v8;
// using namespace std;

// void agent_init(const FunctionCallbackInfo<Value>& args){
//     printf("[sau_analysis_service] Initializing the inference agent\n");
//     tl_infer_agent_init();
//     printf("[sau_analysis_service] Inference agent initialized\n");
// }

// void agent_infer(const FunctionCallbackInfo<Value>& args){
//     Local<Object> bufferObj = args[0].As<Object>();
//     uint8_t* dataBuffer = (uint8_t*) node::Buffer::Data(bufferObj);

//     tl_infer_agent_input_t input = {
//         .puData = dataBuffer,
//         .len = node::Buffer::Length(bufferObj)
//     };
    
//     printf("[sau_analysis_service] Feeding input to the inference agent\n");
//     tl_infer_agent_feed_input(&input);
//     printf("[sau_analysis_service] Performing inference\n");
//     tl_infer_agent_perform_inference();
//     printf("[sau_analysis_service] Fetching output from the inference agent\n");
//     tl_infer_agent_output_t output = tl_infer_agent_get_output();

//     printf("[sau_analysis_service] Inference output: %d\n", output);
//     Isolate* isolate = Isolate::GetCurrent();
//     HandleScope scope(isolate);
//     args.GetReturnValue().Set(Number::New(isolate, output));
// }

// void init(Local<Object> exports){
//     NODE_SET_METHOD(exports, "agent_init", agent_init);
//     NODE_SET_METHOD(exports, "agent_infer", agent_infer);
// }

// NODE_MODULE(sauas, init)
