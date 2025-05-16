################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/cjson/tests/cjson_add.c \
../src/cjson/tests/compare_tests.c \
../src/cjson/tests/json_patch_tests.c \
../src/cjson/tests/minify_tests.c \
../src/cjson/tests/misc_tests.c \
../src/cjson/tests/misc_utils_tests.c \
../src/cjson/tests/old_utils_tests.c \
../src/cjson/tests/parse_array.c \
../src/cjson/tests/parse_examples.c \
../src/cjson/tests/parse_hex4.c \
../src/cjson/tests/parse_number.c \
../src/cjson/tests/parse_object.c \
../src/cjson/tests/parse_string.c \
../src/cjson/tests/parse_value.c \
../src/cjson/tests/parse_with_opts.c \
../src/cjson/tests/print_array.c \
../src/cjson/tests/print_number.c \
../src/cjson/tests/print_object.c \
../src/cjson/tests/print_string.c \
../src/cjson/tests/print_value.c \
../src/cjson/tests/readme_examples.c \
../src/cjson/tests/unity_setup.c 

OBJS += \
./src/cjson/tests/cjson_add.o \
./src/cjson/tests/compare_tests.o \
./src/cjson/tests/json_patch_tests.o \
./src/cjson/tests/minify_tests.o \
./src/cjson/tests/misc_tests.o \
./src/cjson/tests/misc_utils_tests.o \
./src/cjson/tests/old_utils_tests.o \
./src/cjson/tests/parse_array.o \
./src/cjson/tests/parse_examples.o \
./src/cjson/tests/parse_hex4.o \
./src/cjson/tests/parse_number.o \
./src/cjson/tests/parse_object.o \
./src/cjson/tests/parse_string.o \
./src/cjson/tests/parse_value.o \
./src/cjson/tests/parse_with_opts.o \
./src/cjson/tests/print_array.o \
./src/cjson/tests/print_number.o \
./src/cjson/tests/print_object.o \
./src/cjson/tests/print_string.o \
./src/cjson/tests/print_value.o \
./src/cjson/tests/readme_examples.o \
./src/cjson/tests/unity_setup.o 

C_DEPS += \
./src/cjson/tests/cjson_add.d \
./src/cjson/tests/compare_tests.d \
./src/cjson/tests/json_patch_tests.d \
./src/cjson/tests/minify_tests.d \
./src/cjson/tests/misc_tests.d \
./src/cjson/tests/misc_utils_tests.d \
./src/cjson/tests/old_utils_tests.d \
./src/cjson/tests/parse_array.d \
./src/cjson/tests/parse_examples.d \
./src/cjson/tests/parse_hex4.d \
./src/cjson/tests/parse_number.d \
./src/cjson/tests/parse_object.d \
./src/cjson/tests/parse_string.d \
./src/cjson/tests/parse_value.d \
./src/cjson/tests/parse_with_opts.d \
./src/cjson/tests/print_array.d \
./src/cjson/tests/print_number.d \
./src/cjson/tests/print_object.d \
./src/cjson/tests/print_string.d \
./src/cjson/tests/print_value.d \
./src/cjson/tests/readme_examples.d \
./src/cjson/tests/unity_setup.d 


# Each subdirectory must supply rules for building sources it contributes
src/cjson/tests/%.o: ../src/cjson/tests/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../zynq_rtos_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


