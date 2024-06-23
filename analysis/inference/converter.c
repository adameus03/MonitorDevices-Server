#include "converter.h"
//#include <jpeglib.h>

#include <turbojpeg.h>

#include <stdlib.h>


void converter_jfif2rgb(uint8_t* pJfifData, 
                        uint32_t jfifDataLen, 
                        uint8_t** puRgbData_out,
                        uint32_t* pRgbDataLen_out,
                        uint32_t* pImageWidth_out, 
                        uint32_t* pImageHeight_out) {
    
    tjhandle jpegDecompressor = tjInitDecompress();
    if(jpegDecompressor == NULL){
        return;
    }

    int width, height, jpegSubsamp;
    if(tjDecompressHeader2(jpegDecompressor, pJfifData, jfifDataLen, &width, &height, &jpegSubsamp) != 0){
        tjDestroy(jpegDecompressor);
        return;
    }

    uint8_t* puRgbData = (uint8_t*)malloc(width * height * 3);
    if(puRgbData == NULL){
        tjDestroy(jpegDecompressor);
        return;
    }

    if(tjDecompress2(jpegDecompressor, pJfifData, jfifDataLen, puRgbData, width, 0, height, TJPF_RGB, TJFLAG_FASTDCT) != 0){
        free(puRgbData);
        tjDestroy(jpegDecompressor);
        return;
    }

    tjDestroy(jpegDecompressor);

    *pImageWidth_out = width;
    *pImageHeight_out = height;
    *pRgbDataLen_out = width * height * 3;
    *puRgbData_out = puRgbData;
}

void converter_resize_skip_rgb(uint8_t* pRgbData, 
                           uint32_t rgbDataLen, 
                           uint32_t imageWidth, 
                           uint32_t imageHeight, 
                           uint32_t newWidth, 
                           uint32_t newHeight, 
                           uint8_t** ppResizedRgbData_out, 
                           uint32_t* pResizedRgbDataLen_out) {
    *ppResizedRgbData_out = (uint8_t*)malloc(newWidth * newHeight * 3);
    if(*ppResizedRgbData_out == NULL){
        return;
    }

    for (uint32_t i = 0; i < newHeight; i++){
        for (uint32_t j = 0; j < newWidth; j++){
            double relX = (double)j / (double)newWidth;
            double relY = (double)i / (double)newHeight;

            uint32_t __iO = (uint32_t)(relY * imageHeight);
            uint32_t __jO = (uint32_t)(relX * imageWidth);

            (*ppResizedRgbData_out)[i * newWidth * 3 + j * 3] = pRgbData[__iO * imageWidth * 3 + __jO * 3];
            (*ppResizedRgbData_out)[i * newWidth * 3 + j * 3 + 1] = pRgbData[__iO * imageWidth * 3 + __jO * 3 + 1];
            (*ppResizedRgbData_out)[i * newWidth * 3 + j * 3 + 2] = pRgbData[__iO * imageWidth * 3 + __jO * 3 + 2];
        }
    }

    *pResizedRgbDataLen_out = newWidth * newHeight * 3;
}