#! /bin/bash

TARGET="${1}"

IS_DEBUG="false"
[ "${TARGET}" == "Debug" ] && IS_DEBUG="true"

IS_GGP="false"
[ ! -z "${2}" ] && [ "${2}" == "ggp" ] && IS_GGP="true"

cd angle
gn gen out/${TARGET} --args="target_cpu=\"x64\" is_debug=${IS_DEBUG} angle_enable_gl=false angle_enable_null=false angle_swiftshader=false is_ggp=${IS_GGP} use_custom_libcxx=${IS_GGP}"

# This header has to be in Vulkan-Headers!
mkdir thirdparty/vulkan-headers/src/include/ggp_c
cat > thirdparty/vulkan-headers/src/include/ggp_c/vulkan_types.h << EOF
typedef uint64_t GgpFrameToken;
typedef uint32_t GgpStreamDescriptor;
static const uint32_t kGgpPrimaryStreamDescriptor = 1;
EOF
