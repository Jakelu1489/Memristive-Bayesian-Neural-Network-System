################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/cjson/tests/unity/extras/fixture/test/template_fixture_tests.c \
../src/cjson/tests/unity/extras/fixture/test/unity_fixture_Test.c \
../src/cjson/tests/unity/extras/fixture/test/unity_fixture_TestRunner.c \
../src/cjson/tests/unity/extras/fixture/test/unity_output_Spy.c 

OBJS += \
./src/cjson/tests/unity/extras/fixture/test/template_fixture_tests.o \
./src/cjson/tests/unity/extras/fixture/test/unity_fixture_Test.o \
./src/cjson/tests/unity/extras/fixture/test/unity_fixture_TestRunner.o \
./src/cjson/tests/unity/extras/fixture/test/unity_output_Spy.o 

C_DEPS += \
./src/cjson/tests/unity/extras/fixture/test/template_fixture_tests.d \
./src/cjson/tests/unity/extras/fixture/test/unity_fixture_Test.d \
./src/cjson/tests/unity/extras/fixture/test/unity_fixture_TestRunner.d \
./src/cjson/tests/unity/extras/fixture/test/unity_output_Spy.d 


# Each subdirectory must supply rules for building sources it contributes
src/cjson/tests/unity/extras/fixture/test/%.o: ../src/cjson/tests/unity/extras/fixture/test/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../zynq_rtos_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


