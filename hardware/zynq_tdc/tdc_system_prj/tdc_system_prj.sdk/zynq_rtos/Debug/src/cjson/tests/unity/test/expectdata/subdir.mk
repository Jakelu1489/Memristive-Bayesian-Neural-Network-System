################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/cjson/tests/unity/test/expectdata/testsample_cmd.c \
../src/cjson/tests/unity/test/expectdata/testsample_def.c \
../src/cjson/tests/unity/test/expectdata/testsample_head1.c \
../src/cjson/tests/unity/test/expectdata/testsample_mock_cmd.c \
../src/cjson/tests/unity/test/expectdata/testsample_mock_def.c \
../src/cjson/tests/unity/test/expectdata/testsample_mock_head1.c \
../src/cjson/tests/unity/test/expectdata/testsample_mock_new1.c \
../src/cjson/tests/unity/test/expectdata/testsample_mock_new2.c \
../src/cjson/tests/unity/test/expectdata/testsample_mock_param.c \
../src/cjson/tests/unity/test/expectdata/testsample_mock_run1.c \
../src/cjson/tests/unity/test/expectdata/testsample_mock_run2.c \
../src/cjson/tests/unity/test/expectdata/testsample_mock_yaml.c \
../src/cjson/tests/unity/test/expectdata/testsample_new1.c \
../src/cjson/tests/unity/test/expectdata/testsample_new2.c \
../src/cjson/tests/unity/test/expectdata/testsample_param.c \
../src/cjson/tests/unity/test/expectdata/testsample_run1.c \
../src/cjson/tests/unity/test/expectdata/testsample_run2.c \
../src/cjson/tests/unity/test/expectdata/testsample_yaml.c 

OBJS += \
./src/cjson/tests/unity/test/expectdata/testsample_cmd.o \
./src/cjson/tests/unity/test/expectdata/testsample_def.o \
./src/cjson/tests/unity/test/expectdata/testsample_head1.o \
./src/cjson/tests/unity/test/expectdata/testsample_mock_cmd.o \
./src/cjson/tests/unity/test/expectdata/testsample_mock_def.o \
./src/cjson/tests/unity/test/expectdata/testsample_mock_head1.o \
./src/cjson/tests/unity/test/expectdata/testsample_mock_new1.o \
./src/cjson/tests/unity/test/expectdata/testsample_mock_new2.o \
./src/cjson/tests/unity/test/expectdata/testsample_mock_param.o \
./src/cjson/tests/unity/test/expectdata/testsample_mock_run1.o \
./src/cjson/tests/unity/test/expectdata/testsample_mock_run2.o \
./src/cjson/tests/unity/test/expectdata/testsample_mock_yaml.o \
./src/cjson/tests/unity/test/expectdata/testsample_new1.o \
./src/cjson/tests/unity/test/expectdata/testsample_new2.o \
./src/cjson/tests/unity/test/expectdata/testsample_param.o \
./src/cjson/tests/unity/test/expectdata/testsample_run1.o \
./src/cjson/tests/unity/test/expectdata/testsample_run2.o \
./src/cjson/tests/unity/test/expectdata/testsample_yaml.o 

C_DEPS += \
./src/cjson/tests/unity/test/expectdata/testsample_cmd.d \
./src/cjson/tests/unity/test/expectdata/testsample_def.d \
./src/cjson/tests/unity/test/expectdata/testsample_head1.d \
./src/cjson/tests/unity/test/expectdata/testsample_mock_cmd.d \
./src/cjson/tests/unity/test/expectdata/testsample_mock_def.d \
./src/cjson/tests/unity/test/expectdata/testsample_mock_head1.d \
./src/cjson/tests/unity/test/expectdata/testsample_mock_new1.d \
./src/cjson/tests/unity/test/expectdata/testsample_mock_new2.d \
./src/cjson/tests/unity/test/expectdata/testsample_mock_param.d \
./src/cjson/tests/unity/test/expectdata/testsample_mock_run1.d \
./src/cjson/tests/unity/test/expectdata/testsample_mock_run2.d \
./src/cjson/tests/unity/test/expectdata/testsample_mock_yaml.d \
./src/cjson/tests/unity/test/expectdata/testsample_new1.d \
./src/cjson/tests/unity/test/expectdata/testsample_new2.d \
./src/cjson/tests/unity/test/expectdata/testsample_param.d \
./src/cjson/tests/unity/test/expectdata/testsample_run1.d \
./src/cjson/tests/unity/test/expectdata/testsample_run2.d \
./src/cjson/tests/unity/test/expectdata/testsample_yaml.d 


# Each subdirectory must supply rules for building sources it contributes
src/cjson/tests/unity/test/expectdata/%.o: ../src/cjson/tests/unity/test/expectdata/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../zynq_rtos_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


