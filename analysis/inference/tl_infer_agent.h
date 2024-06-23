#include <stdint.h>

#define TL_INFER_AGENT_NUM_COLS 224
#define TL_INFER_AGENT_NUM_ROWS 224
#define TL_INFER_AGENT_NUM_CHANNELS 3
#define TL_INFER_AGENT_CATEGORY_COUNT 2
#define TL_INFER_AGENT_NOTIFY_INDEX 1
#define TL_INFER_AGENT_NOP_INDEX 0

#define TL_AGENT_MODEL_PATH "surveillance_mobilenet_10_epochs_fixed_LS_90_balanced.tflite"

#define TL_AGENT_INPUT_CHANNEL_RED_NORMALIZATION__MEAN 0.485
#define TL_AGENT_INPUT_CHANNEL_RED_NORMALIZATION__STDEV 0.229
#define TL_AGENT_INPUT_CHANNEL_GREEN_NORMALIZATION__MEAN 0.456
#define TL_AGENT_INPUT_CHANNEL_GREEN_NORMALIZATION__STDEV 0.224
#define TL_AGENT_INPUT_CHANNEL_BLUE_NORMALIZATION__MEAN 0.406
#define TL_AGENT_INPUT_CHANNEL_BLUE_NORMALIZATION__STDEV 0.225

typedef struct {
    /* JFIF data buffer */
    uint8_t* puData;
    /* Length of the JFIF data buffer */
    uint32_t len;
} tl_infer_agent_input_t;

typedef enum {
    TL_INFER_AGENT_OUTPUT_NO_ACTION = 0U,
    TL_INFER_AGENT_OUTPUT_TRIGGER_ACTION = 1U
} tl_infer_agent_output_t;

#ifdef __cplusplus
extern "C"
{
#endif
void tl_infer_agent_init();
/**
 * @param pInput Pointer to the input struct containing JFIF image data
*/
void tl_infer_agent_feed_input(tl_infer_agent_input_t* pInput);
void tl_infer_agent_perform_inference();
tl_infer_agent_output_t tl_infer_agent_get_output();
#ifdef __cplusplus
}
#endif