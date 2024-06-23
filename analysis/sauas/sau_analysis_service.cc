#include <v8.h>
#include <node.h>
#include <node_buffer.h>
#include <stdio.h>

#include <semaphore.h>
#include <sys/ipc.h>
#include <sys/shm.h>

using namespace v8;
using namespace std;

#define SHM_KEY 0xfedcba98
// 4k -> 3480 x 216
// 3480 * 2160 * 2 = 16588800
#define MAX_JFIF_SZ 16588800 

typedef struct {
    sem_t fromInference_semph;
    sem_t toInference_semph;
    uint8_t output;
    uint64_t buf_sz;
    uint8_t buf[MAX_JFIF_SZ];
} sau_shm_t;

static int SHM_ID = -1;
static sau_shm_t* __inference = NULL;

static sem_t multicall_guard_semph;

// void agent_init(const FunctionCallbackInfo<Value>& args){
//     printf("[sau_analysis_service] Initializing the inference agent\n");
//     tl_infer_agent_init();
//     printf("[sau_analysis_service] Inference agent initialized\n");
// }

#define SAUAS_CRITICAL_SECTION_BEGIN sem_wait(&multicall_guard_semph);
#define SAUAS_CRITICAL_SECTION_END sem_post(&multicall_guard_semph);

#define OPTLOG if(0) 

void agent_infer(const FunctionCallbackInfo<Value>& args){
    Local<Object> bufferObj = args[0].As<Object>();
    uint8_t* dataBuffer = (uint8_t*) node::Buffer::Data(bufferObj);

    // tl_infer_agent_input_t input = {
    //     .puData = dataBuffer,
    //     .len = node::Buffer::Length(bufferObj)
    // };
    
    // printf("[sau_analysis_service] Feeding input to the inference agent\n");
    // tl_infer_agent_feed_input(&input);
    // printf("[sau_analysis_service] Performing inference\n");
    // tl_infer_agent_perform_inference();
    // printf("[sau_analysis_service] Fetching output from the inference agent\n");
    // tl_infer_agent_output_t output = tl_infer_agent_get_output();

    // printf("[sau_analysis_service] Inference output: %d\n", output);

    OPTLOG fprintf(stdout, "[sau_analysis_service] Waiting for critical section\n");
    SAUAS_CRITICAL_SECTION_BEGIN

    OPTLOG fprintf(stdout, "[sau_analysis_service] Entered critical section\n");
    OPTLOG fprintf(stdout, "[sau_analysis_service] Setting buffer size\n");
    __inference->buf_sz = node::Buffer::Length(bufferObj);
    OPTLOG fprintf(stdout, "[sau_analysis_service] Copying buffer data to shared memory\n");
    memcpy(__inference->buf, dataBuffer, __inference->buf_sz);
    OPTLOG fprintf(stdout, "[sau_analysis_service] Posting to inference\n");
    sem_post(&__inference->toInference_semph);
    OPTLOG fprintf(stdout, "[sau_analysis_service] Waiting for inference output\n");
    sem_wait(&__inference->fromInference_semph);
    OPTLOG fprintf(stdout, "[sau_analysis_service] Inference output obtained\n");
    uint8_t output = __inference->output;
    OPTLOG fprintf(stdout, "[sau_analysis_service] Inference output: %u\n", output);

    OPTLOG fprintf(stdout, "[sau_analysis_service] Exiting critical section\n");

    SAUAS_CRITICAL_SECTION_END

    OPTLOG fprintf(stdout, "[sau_analysis_service] Sending output to Node.js\n");

    Isolate* isolate = Isolate::GetCurrent();
    HandleScope scope(isolate);
    args.GetReturnValue().Set(Number::New(isolate, output));

    OPTLOG fprintf(stdout, "[sau_analysis_service] Output returned to Node.js\n");
}

static void setup() {
    // Connect to shared memory created by the inference process
    fprintf(stdout, "[sau_analysis_service] Connecting to shared memory\n");
    SHM_ID = shmget(SHM_KEY, sizeof(sau_shm_t), 0777); // [TODO] Adjust permissions
    if (SHM_ID == -1) {
        fprintf(stderr, "[sau_analysis_service] Failed to obtain shared memory\n");
        exit(EXIT_FAILURE);
    }
    fprintf(stdout, "[sau_analysis_service] Shared memory obtained\n");
    __inference = (sau_shm_t*) shmat(SHM_ID, NULL, 0);
    if (!((int64_t)__inference > 0)) {
        fprintf(stderr, "[sau_analysis_service] Failed to attach to shared memory\n");
        exit(EXIT_FAILURE);
    }
    fprintf(stdout, "[sau_analysis_service] Shared memory attached at %p\n", __inference);

    // Initialize the multicall guard semaphore
    fprintf(stdout, "[sau_analysis_service] Initializing multicall_guard_semph\n");
    if (-1 == sem_init(&multicall_guard_semph, 1, 1)) {
        fprintf(stderr, "[sau_analysis_service] Failed to initialize multicall_guard_semph\n");
        exit(EXIT_FAILURE);
    }
    fprintf(stdout, "[sau_analysis_service] Initialized multicall_guard_semph\n");
    fprintf(stdout, "[sau_analysis_service] Returning control to Node.js\n");
}

void init(Local<Object> exports){
    setup();

    // NODE_SET_METHOD(exports, "agent_init", agent_init);
    NODE_SET_METHOD(exports, "agent_infer", agent_infer);
}

NODE_MODULE(sauas, init)
