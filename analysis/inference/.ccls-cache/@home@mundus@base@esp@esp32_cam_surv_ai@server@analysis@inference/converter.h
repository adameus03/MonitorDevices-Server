#include <stdint.h>
#include <stdio.h>


#ifdef __cplusplus
extern "C"
{
#endif
/**
 * @brief Converts a JFIF image to RGB format
 * @param pJfifData Pointer to the JFIF image data
 * @param jfifDataLen Length of the JFIF image data
 * @param ppRgbData_out [out] Pointer to the address where the RGB data will be stored
 * @param pRgbDataLen_out [out] Pointer to the length of the RGB image data
 * @param pImageWidth_out [out] Pointer to the image width
 * @param pImageHeight_out [out] Pointer to the image height
 * @note This function will allocate memory for the RGB data. The caller is responsible for freeing the memory.
 */
void converter_jfif2rgb(uint8_t* pJfifData, 
                        uint32_t jfifDataLen, 
                        uint8_t** ppRgbData_out,
                        uint32_t* pRgbDataLen_out,
                        uint32_t* pImageWidth_out, 
                        uint32_t* pImageHeight_out);


/**
 * @brief Resizes an RGB image by skipping or interpolating pixels
 * @param pRgbData Pointer to the RGB image data
 * @param rgbDataLen Length of the RGB image data
 * @param imageWidth Width of the image
 * @param imageHeight Height of the image
 * @param newWidth New width of the image
 * @param newHeight New height of the image
 * @param ppResizedRgbData_out [out] Pointer to the address where the resized RGB data will be stored
 * @param pResizedRgbDataLen_out [out] Pointer to the length of the resized RGB image data
 * @note This function will allocate memory for the resized RGB data. The caller is responsible for freeing the memory.
 */
void converter_resize_skip_rgb(uint8_t* pRgbData, 
                           uint32_t rgbDataLen, 
                           uint32_t imageWidth, 
                           uint32_t imageHeight, 
                           uint32_t newWidth, 
                           uint32_t newHeight, 
                           uint8_t** ppResizedRgbData_out, 
                           uint32_t* pResizedRgbDataLen_out);

#ifdef __cplusplus
}
#endif