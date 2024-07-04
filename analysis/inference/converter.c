#include "converter.h"
//#include <jpeglib.h>

#include <turbojpeg.h>

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>


#pragma pack(push, 1)
typedef struct {
    uint16_t bfType;
    uint32_t bfSize;
    uint16_t bfReserved1;
    uint16_t bfReserved2;
    uint32_t bfOffBits;
} BITMAPFILEHEADER;
typedef struct {
    uint32_t biSize;
    int32_t biWidth;
    int32_t biHeight;
    uint16_t biPlanes;
    uint16_t biBitCount;
    uint32_t biCompression;
    uint32_t biSizeImage;
    int32_t biXPelsPerMeter;
    int32_t biYPelsPerMeter;
    uint32_t biClrUsed;
    uint32_t biClrImportant;
} BITMAPINFOHEADER;
#pragma pack(pop)

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

    // Bottom up
    if(tjDecompress2(jpegDecompressor, pJfifData, jfifDataLen, puRgbData, width, 0, height, TJPF_BGR, TJFLAG_FASTDCT) != 0) {
        free(puRgbData);
        tjDestroy(jpegDecompressor);
        return;
    }

    tjDestroy(jpegDecompressor);

    // Reverse the order of the rows
    //for (int i = 0; i < height / 2; i++){
    //    for (int j = 0; j < width * 3; j++){
    //        uint8_t temp = puRgbData[i * width * 3 + j];
    //        puRgbData[i * width * 3 + j] = puRgbData[(height - i - 1) * width * 3 + j];
    //        puRgbData[(height - i - 1) * width * 3 + j] = temp;
    //    }
    //}

    *pImageWidth_out = width;
    *pImageHeight_out = height;
    *pRgbDataLen_out = width * height * 3;
    *puRgbData_out = puRgbData;

    // Save bitmap made of puRgbData_out to a file for debugging
    FILE* f = fopen("/sau/debug_original_sizey.bmp", "wb");
    if(f == NULL){
        return;
    }

    BITMAPFILEHEADER bfh;
    BITMAPINFOHEADER bih;

    bfh.bfType = 0x4D42; // 'BM'
    bfh.bfSize = sizeof(BITMAPFILEHEADER) + sizeof(BITMAPINFOHEADER) + *pRgbDataLen_out;
    bfh.bfReserved1 = 0;
    bfh.bfReserved2 = 0;
    bfh.bfOffBits = sizeof(BITMAPFILEHEADER) + sizeof(BITMAPINFOHEADER);

    bih.biSize = sizeof(BITMAPINFOHEADER);
    bih.biWidth = width;
    bih.biHeight = height;
    bih.biPlanes = 1;
    bih.biBitCount = 24;
    bih.biCompression = 0; // BI_RGB
    bih.biSizeImage = *pRgbDataLen_out;
    bih.biXPelsPerMeter = 0;
    bih.biYPelsPerMeter = 0;
    bih.biClrUsed = 0;
    bih.biClrImportant = 0;

    fwrite(&bfh, sizeof(BITMAPFILEHEADER), 1, f);
    fwrite(&bih, sizeof(BITMAPINFOHEADER), 1, f);
    fwrite(*puRgbData_out, *pRgbDataLen_out, 1, f);

    fclose(f);

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

    // Save bitmap made of ppResizedRgbData_out to a file for debugging
    FILE* f = fopen("/sau/debug_resizedy.bmp", "wb");
    if(f == NULL){
        return;
    }

    BITMAPFILEHEADER bfh;
    BITMAPINFOHEADER bih;

    bfh.bfType = 0x4D42; // 'BM'
    bfh.bfSize = sizeof(BITMAPFILEHEADER) + sizeof(BITMAPINFOHEADER) + *pResizedRgbDataLen_out;
    bfh.bfReserved1 = 0;
    bfh.bfReserved2 = 0;
    bfh.bfOffBits = sizeof(BITMAPFILEHEADER) + sizeof(BITMAPINFOHEADER);

    bih.biSize = sizeof(BITMAPINFOHEADER);
    bih.biWidth = newWidth;
    bih.biHeight = newHeight;
    bih.biPlanes = 1;
    bih.biBitCount = 24;
    bih.biCompression = 0; // BI_RGB
    bih.biSizeImage = *pResizedRgbDataLen_out;
    bih.biXPelsPerMeter = 0;
    bih.biYPelsPerMeter = 0;
    bih.biClrUsed = 0;
    bih.biClrImportant = 0;

    fwrite(&bfh, sizeof(BITMAPFILEHEADER), 1, f);
    fwrite(&bih, sizeof(BITMAPINFOHEADER), 1, f);
    fwrite(*ppResizedRgbData_out, *pResizedRgbDataLen_out, 1, f);

    fclose(f);
}

void converter_transpose_rgb(uint8_t* pRgbData, 
                           uint32_t imageWidth, 
                           uint32_t imageHeight, 
                           uint8_t** ppTransposedRgbData_out) {
    //fprintf(stdout, "IN converter_transpose_rgb (fprintf)\n");
    //printf("IN converter_transpose_rgb (printf)\n");
    *ppTransposedRgbData_out = (uint8_t*)malloc(imageWidth * imageHeight * 3);
    if(*ppTransposedRgbData_out == NULL){
        return;
    }

    uint32_t pixelsCount = imageWidth * imageHeight;

    uint8_t* pOutChannelR = *ppTransposedRgbData_out;
    uint8_t* pOutChannelG = pOutChannelR + pixelsCount;
    uint8_t* pOutChannelB = pOutChannelG + pixelsCount;

    for (uint32_t i = 0U; i < imageWidth; i++) { // iterate over columns
        for (uint32_t j = 0U; j < imageHeight; j++) { // iterate over rows
	    //assert((int)(pOutChannelG - pOutChannelR) == 153600);
	    //assert((int)(pOutChannelB - pOutChannelG) == 153600);

            //assert(i * imageHeight + j < pixelsCount);
	    //assert(j * imageWidth * 3 + i + 2 < pixelsCount * 3); 

	    //printf("i = %u, j = %u, imageWidth = %u, imageHeight = %u\n", i, j, imageWidth, imageHeight);
            
	    //pOutChannelR[i * imageHeight + j] = pRgbData[j * imageWidth * 3 + i * 3];
            //pOutChannelG[i * imageHeight + j] = pRgbData[j * imageWidth * 3 + i * 3 + 1];
            //pOutChannelB[i * imageHeight + j] = pRgbData[j * imageWidth * 3 + i * 3 + 2];
	    pOutChannelR[j * imageWidth + i] = pRgbData[j * imageWidth * 3 + i * 3];
	    pOutChannelG[j * imageWidth + i] = pRgbData[j * imageWidth * 3 + i * 3 + 1];
	    pOutChannelB[j * imageWidth + i] = pRgbData[j * imageWidth * 3 + i * 3 + 2];

        }
    }

}
