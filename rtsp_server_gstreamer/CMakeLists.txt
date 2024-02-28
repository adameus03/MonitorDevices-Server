cmake_minimum_required(VERSION 3.0.0)
project(rtsp_server_gstreamer VERSION 0.1.0 LANGUAGES C)

find_package(PkgConfig REQUIRED)
pkg_check_modules(GSTLIBS REQUIRED 
    gobject-2.0
    glib-2.0
    gstreamer-webrtc-1.0
    gstreamer-sdp-1.0
    gstreamer-pbutils-1.0
    gstreamer-check-1.0
    gstreamer-rtsp-server-1.0
)

include_directories(${GSTLIBS_INCLUDE_DIRS})
#target_include_directories(${PROJECT_NAME} PUBLIC ${GSTLIBS_INCLUDE_DIRS})
link_directories(${GSTLIBS_LIBRARY_DIRS})
add_executable(${PROJECT_NAME} main.c)

target_link_libraries(${PROJECT_NAME} ${GSTLIBS_LIBRARIES})
#link against jpeg-turbo
target_link_libraries(${PROJECT_NAME} -ljpeg)

# cmake_minimum_required(VERSION 3.15.3)
# project(rtsp_server_gstreamer VERSION 0.1.0 LANGUAGES C)

# find_package(PkgConfig REQUIRED)
# pkg_check_modules(gtk3 REQUIRED IMPORTED_TARGET gtk+-3.0)
# pkg_search_module(gstreamer REQUIRED IMPORTED_TARGET gstreamer-1.0>=1.4)
# pkg_search_module(gstreamer-sdp REQUIRED IMPORTED_TARGET gstreamer-sdp-1.0>=1.4)
# pkg_search_module(gstreamer-app REQUIRED IMPORTED_TARGET gstreamer-app-1.0>=1.4)
# pkg_search_module(gstreamer-video REQUIRED IMPORTED_TARGET gstreamer-video-1.0>=1.4)

# add_executable(${PROJECT_NAME} main.c)

# target_link_libraries(${PROJECT_NAME}
#     PkgConfig::gtk3
#     PkgConfig::gstreamer
#     PkgConfig::gstreamer-sdp
#     PkgConfig::gstreamer-app
#     PkgConfig::gstreamer-video
# )