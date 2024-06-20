# [WARNING] [TODO] Not tested yet

ARG expose_port=80
FROM debian:bookworm
RUN mkdir -p /opt/app
WORKDIR /opt/app

RUN sudo apt install -y cmake g++ git libeigen3-dev libabsl-dev libgemmlowp-dev libneon2sse-dev libfarmhash-dev libpthreadpool-dev libruy-dev libpthreadpool-dev

# [TODO] Build and install flatbuffers and ruy

RUN mkdir -p analysis/tflite_build
WORKDIR /opt/app/analysis/tflite_build
RUN cmake ../base/esp/esp32_cam_surv_ai/server/analysis/tensorflow/tensorflow/lite -DTFLITE_ENABLE_INSTALL=ON \
-DCMAKE_FIND_PACKAGE_PREFER_CONFIG=ON \
-DSYSTEM_FARMHASH=ON \
-DSYSTEM_PTHREADPOOL=ON \
-Dabsl_DIR=/usr/lib/x86_64-linux-gnu/cmake/absl \
-DEigen3_DIR=/usr/share/eigen3/cmake \
-DFlatBuffers_DIR=/usr/local/lib/cmake/flatbuffers \
-Dgemmlowp_DIR=/usr/lib/x86_64-linux-gnu/cmake/gemmlowp \
-DNEON_2_SSE_DIR=/usr/lib/cmake/NEON_2_SSE \
-Dcpuinfo_DIR=/usr/bin/cpu-info \
-Druy_DIR=/usr/local/lib/cmake/ruy

# Build TF Lite
RUN cmake --build -j16 .

RUN apt install -y sqlite3 libsqlite3-dev

# Copy C/CXX build files to the container
WORKDIR /opt/app/analysis
COPY analysis/inference/build/ ./

# Copy the tflite model to the container
COPY analyss/inference/surveillance_mobilenet_10_epochs_fixed_LS_90_balanced.tflite ../

WORKDIR /opt/app
COPY src/package.json src/package-lock.json ./
RUN npm install
COPY src/ .

RUN npx tsc
COPY .env ./transpiled/bin/
EXPOSE $expose_port

CMD ["/bin/sh", "./start.sh"]

