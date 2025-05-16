################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/cjson/tests/unity/test/testdata/testRunnerGenerator.c \
../src/cjson/tests/unity/test/testdata/testRunnerGeneratorSmall.c \
../src/cjson/tests/unity/test/testdata/testRunnerGeneratorWithMocks.c 

OBJS += \
./src/cjson/tests/unity/test/testdata/testRunnerGenerator.o \
./src/cjson/tests/unity/test/testdata/testRunnerGeneratorSmall.o \
./src/cjson/tests/unity/test/testdata/testRunnerGeneratorWithMocks.o 

C_DEPS += \
./src/cjson/tests/unity/test/testdata/testRunnerGenerator.d \
./src/cjson/tests/unity/test/testdata/testRunnerGeneratorSmall.d \
./src/cjson/tests/unity/test/testdata/testRunnerGeneratorWithMocks.d 


# Each subdirectory must supply rules for building sources it contributes
src/cjson/tests/unity/test/testdata/%.o: ../src/cjson/tests/unity/test/testdata/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../zynq_rtos_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


