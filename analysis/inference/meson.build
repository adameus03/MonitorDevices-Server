project('test', 'cpp', version : '0.1', default_options : ['warning_level=3', 'cpp_std=c++11'])

myLib_lib = 'libtensorflow_cc.so'

myLib_dir = '/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/tensorflow/bazel-bin/tensorflow'

myLib_dep = declare_dependency(link_args : ['-L' + myLib_dir, '-l' + myLib_lib] )

executable('testProg', sources : ['main.cc'], build_rpath : myLib_dir, install_rpath : myLib_dir, dependencies : [myLib_dep])