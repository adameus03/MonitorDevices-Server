/* GStreamer
 * Copyright (C) 2008 Wim Taymans <wim.taymans at gmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin St, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */

#include <stdio.h>
#include <stdint.h>
#include <gst/gst.h>
#include <gst/rtsp-server/rtsp-server.h>
// include libjpeg-turbo
#include <jpeglib.h>

typedef struct
{
  //gboolean white;
  GstClockTime timestamp;
} MyContext;

/* BUGGED Convert jpeg to rgb565, 4:2:0 */
void buggy_gpt_jpeg2rgb(uint8_t *jpeg_data, uint8_t *rgb_data, int width, int height) {
  struct jpeg_decompress_struct cinfo;
  struct jpeg_error_mgr jerr;
  JSAMPROW row_pointer[1];
  int row_stride;
  cinfo.err = jpeg_std_error(&jerr);
  jpeg_create_decompress(&cinfo);
  jpeg_mem_src(&cinfo, jpeg_data, width * height * 2);
  jpeg_read_header(&cinfo, TRUE);
  jpeg_start_decompress(&cinfo);
  row_stride = cinfo.output_width * cinfo.output_components;
  while (cinfo.output_scanline < cinfo.output_height) {
    row_pointer[0] = &rgb_data[cinfo.output_scanline * row_stride];
    jpeg_read_scanlines(&cinfo, row_pointer, 1);
  }
  jpeg_finish_decompress(&cinfo);
  jpeg_destroy_decompress(&cinfo);

  // tjhandle _jpegCompressor = tjInitCompress();
  // tjCompress2(_jpegCompressor, buffer, width, 0, height, TJPF_RGB, &_compressedImage, &_jpegSize, TJSAMP_444, JPEG_QUALITY, TJFLAG_FASTDCT);
  // tjDestroy(_jpegCompressor);
  
}

/**
 * Adapted from https://github.com/perigoso/jpeg-to-rgb565/blob/master/src/main.c
 * The output RGB565 buffer must be freed using free()
*/
void github_jpeg2rgb(FILE* fIn, int width, int height, uint8_t** out_rgb565_addr, int* out_rgb565_size) {
  struct jpeg_decompress_struct info; //for our jpeg info
  struct jpeg_error_mgr err; //the error handler

  info.err = jpeg_std_error(&err);
  jpeg_create_decompress(&info); //fills info structure

  jpeg_stdio_src(&info, fIn);
  jpeg_read_header(&info, TRUE);

  jpeg_start_decompress(&info);

  int w = info.output_width;
  int h = info.output_height;
  int numChannels = info.num_components; // 3 = RGB, 4 = RGBA
  unsigned long dataSize = w * h * numChannels;

  // read RGB(A) scanlines one at a time into jdata[]
  unsigned char *data = (unsigned char *)malloc(dataSize);
  unsigned char* rowptr;
  while(info.output_scanline < h)
  {
      rowptr = data + info.output_scanline * w * numChannels;
      jpeg_read_scanlines(&info, &rowptr, 1);
  }

  jpeg_finish_decompress(&info);
  *out_rgb565_addr = data;
  *out_rgb565_size = dataSize;
}



/* called when we need to give data to appsrc */
static void
need_data (GstElement * appsrc, guint unused, MyContext * ctx)
{
//  g_print("Need data\n");

  GstBuffer *buffer;
  guint size;
  GstFlowReturn ret;

  size = 1600 * 1200 * 2;

  buffer = gst_buffer_new_allocate (NULL, size, NULL);

  //gst_buffer_memset (buffer, 0, ctx->white ? 0xff : 0x0, size);
  /*if ((ctx->timestamp / 500000000) % 3 == 0)
  {
    g_print("one\n");
    gst_buffer_memset (buffer, 0, 0xcc, size);
  }
  else if ((ctx->timestamp / 500000000) % 3 == 1)
  {
    gst_buffer_memset (buffer, 0, 0x88, size);
    g_print("two\n");
  }
  else {
    gst_buffer_memset (buffer, 0, 0x44, size);
    g_print("three\n");
  }*/

  // read from jpeg file and fill the buffer


  /*FILE *fp;
  //fp = fopen("/home/mundus/base/esp/esp32_cam_surv_ai/project/live_frame.jpg", "r");
  fp = fopen("/home/mundus/Downloads/wp4470042.jpg", "r");
  //fp = fopen("/home/mundus/base/esp/esp32_cam_surv_ai/project/frame_CENTRAL.jpg", "r");
  if (fp == NULL)
  {
    g_print("Error opening file\n");
    return;
  }
  uint8_t *jfif_data = (uint8_t *)malloc(1600 * 1200 * 2);
  fread(jfif_data, 1, size, fp);
  fclose(fp);
  uint8_t *rgb_data = (uint8_t *)malloc(1600 * 1200 * 3);
  jpeg2rgb(jfif_data, rgb_data, 1600, 1200);
  free(jfif_data);
  gst_buffer_fill(buffer, 0, rgb_data, size);
  free(rgb_data);*/

  //FILE *fp;
  //fp = fopen("/home/mundus/base/esp/esp32_cam_surv_ai/project/live_frame.jpg", "r");
  //fp = fopen("/home/mundus/Downloads/wp4470042.jpg", "r");
  // Use named pipe to read JFIF data
  FILE *fp;
  fp = fopen("/tmp/f8a22310975600b1", "r");
  if (fp == NULL)
  {
    g_print("Error opening file\n");
    return;
  }
  uint8_t* puRgb565;
  int rgb565_size;
  github_jpeg2rgb(fp, 1600, 1200, &puRgb565, &rgb565_size);
  fclose(fp);
  gst_buffer_fill(buffer, 0, puRgb565, rgb565_size);
  free(puRgb565);


  //ctx->white = !ctx->white;

  /* increment the timestamp every 1/2 second */
  GST_BUFFER_PTS (buffer) = ctx->timestamp;
  GST_BUFFER_DURATION (buffer) = gst_util_uint64_scale_int (1, GST_SECOND, 2);
  ctx->timestamp += GST_BUFFER_DURATION (buffer);
  //g_print("New timestamp: %lu\n", ctx->timestamp);

  g_signal_emit_by_name (appsrc, "push-buffer", buffer, &ret);
  gst_buffer_unref (buffer);
}

/* called when a new media pipeline is constructed. We can query the
 * pipeline and configure our appsrc */
static void
media_configure (GstRTSPMediaFactory * factory, GstRTSPMedia * media,
    gpointer user_data)
{
  GstElement *element, *appsrc;
  MyContext *ctx;

  /* get the element used for providing the streams of the media */
  element = gst_rtsp_media_get_element (media);

  /* get our appsrc, we named it 'mysrc' with the name property */
  appsrc = gst_bin_get_by_name_recurse_up (GST_BIN (element), "mysrc");

  /* this instructs appsrc that we will be dealing with timed buffer */
  gst_util_set_object_arg (G_OBJECT (appsrc), "format", "time");
  /* configure the caps of the video */
  g_object_set (G_OBJECT (appsrc), "caps",
      gst_caps_new_simple ("video/x-raw",
          "format", G_TYPE_STRING, "RGB16", // Is this correct?
          "width", G_TYPE_INT, 1600,
          "height", G_TYPE_INT, 1200,
          "framerate", GST_TYPE_FRACTION, 30, 1, NULL), NULL);

  ctx = g_new0 (MyContext, 1);
  //ctx->white = FALSE;
  ctx->timestamp = 0;
  /* make sure ther datais freed when the media is gone */
  g_object_set_data_full (G_OBJECT (media), "my-extra-data", ctx,
      (GDestroyNotify) g_free);

  /* install the callback that will be called when a buffer is needed */
  g_signal_connect (appsrc, "need-data", (GCallback) need_data, ctx);
  gst_object_unref (appsrc);
  gst_object_unref (element);
}

int
main (int argc, char *argv[])
{
  GMainLoop *loop;
  GstRTSPServer *server;
  GstRTSPMountPoints *mounts;
  GstRTSPMediaFactory *factory;

  gst_init (&argc, &argv);

  loop = g_main_loop_new (NULL, FALSE);

  /* create a server instance */
  server = gst_rtsp_server_new ();

  /* get the mount points for this server, every server has a default object
   * that be used to map uri mount points to media factories */
  mounts = gst_rtsp_server_get_mount_points (server);

  /* make a media factory for a test stream. The default media factory can use
   * gst-launch syntax to create pipelines.
   * any launch line works as long as it contains elements named pay%d. Each
   * element with pay%d names will be a stream */
  factory = gst_rtsp_media_factory_new ();
  gst_rtsp_media_factory_set_launch (factory,
      //"( appsrc name=mysrc ! videoconvert ! video/x-raw,format=I420 ! x264enc ! rtph264pay name=pay0 pt=96 )");
      "( appsrc name=mysrc ! videoconvert ! video/x-raw,format=I420 ! x264enc ! rtph264pay name=pay0 )");
      //"( appsrc name=mysrc ! jpegdec ! videoscale ! videoconvert ! x264enc ! h264parse ! mpegtsmux ! rtph264pay name=pay0 pt=96)");
      //"( appsrc name=mysrc ! jpegdec ! videoconvert ! video/x-raw,format=I420 ! x264enc ! rtph264pay name=pay0 pt=96 )");
      //"( multifilesrc location=\"/home/mundus/base/esp/esp32_cam_surv_ai/project/live_frame.jpg\" loop=true start-index=0 stop-index=0  ! image/jpeg,width=1600,height=1200,type=video,framerate=30/1 ! identity ! jpegdec ! videoscale ! videoconvert ! x264enc ! h264parse ! mpegtsmux ! rtpmp2tpay ! udpsink host=127.0.0.1 port=5000 )");
      //"( multifilesrc location=\"/home/mundus/base/esp/esp32_cam_surv_ai/project/live_frame.jpg\" loop=true start-index=0 stop-index=0  ! image/jpeg,width=1600,height=1200,type=video,framerate=30/1 ! identity ! jpegdec ! videoscale ! videoconvert ! x264enc ! h264parse ! mpegtsmux ! rtpmp2tpay )");
  /* notify when our media is ready, This is called whenever someone asks for
   * the media and a new pipeline with our appsrc is created */
  g_signal_connect (factory, "media-configure", (GCallback) media_configure,
      NULL);

  /* attach the test factory to the /test url */
  gst_rtsp_mount_points_add_factory (mounts, "/test", factory);

  /* don't need the ref to the mounts anymore */
  g_object_unref (mounts);

  /* attach the server to the default maincontext */
  gst_rtsp_server_attach (server, NULL);

  /* start serving */
  g_print ("stream ready at rtsp://127.0.0.1:8554/test\n");
  g_main_loop_run (loop);

  return 0;
}
