#
# Get build flags from tensorflow to build custom ops correctly
#

find_package( PythonInterp REQUIRED )

execute_process( COMMAND ${PYTHON_EXECUTABLE} "-c" "from __future__ import print_function; import tensorflow as tf; print(tf.sysconfig.get_include(), end='')"
        OUTPUT_VARIABLE TENSORFLOW_INCLUDE_DIR )
execute_process( COMMAND ${PYTHON_EXECUTABLE} "-c" "from __future__ import print_function; import tensorflow as tf; \
        print(';'.join(flag[2:] for flag in tf.sysconfig.get_compile_flags() if flag.startswith('-D')), end='')"
        OUTPUT_VARIABLE TENSORFLOW_COMPILE_DEFINITIONS )
execute_process(COMMAND ${PYTHON_EXECUTABLE} "-c" "import tensorflow as tf; print(' '.join(tf.sysconfig.get_link_flags()))"
        OUTPUT_VARIABLE TENSORFLOW_LINK_FLAGS OUTPUT_STRIP_TRAILING_WHITESPACE)

message( STATUS "${TENSORFLOW_INCLUDE_DIR}" )
message( STATUS "TensorFlow compile definitions: ${TENSORFLOW_COMPILE_DEFINITIONS}" )
message( STATUS "TensorFlow link flags: ${TENSORFLOW_LINK_FLAGS}" )
