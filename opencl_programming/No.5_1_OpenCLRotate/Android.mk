LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES := rotate.cpp OpenCLRotate.cpp

LOCAL_MODULE := opencl_rotate

LOCAL_SHARED_LIBRARIES := libcutils libutils libOpenCL
LOCAL_MODULE_TAGS := eng optional tests
LOCAL_ARM_MODE := arm

LOCAL_C_INCLUDES := $(TOP)/system/core/include/cutils/ \
			$(LOCAL_PATH)/include \
			$(LOCAL_PATH)/../include

# Mark source files as dependent on Android.mk
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk
include $(BUILD_EXECUTABLE)
