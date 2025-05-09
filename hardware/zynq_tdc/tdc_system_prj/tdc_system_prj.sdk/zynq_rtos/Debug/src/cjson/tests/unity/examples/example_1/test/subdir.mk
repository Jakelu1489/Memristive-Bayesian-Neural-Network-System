################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/cjson/tests/unity/examples/example_1/test/TestProductionCode.c \
../src/cjson/tests/unity/examples/example_1/test/TestProductionCode2.c 

OBJS += \
./src/cjson/tests/unity/examples/example_1/test/TestProductionCode.o \
./src/cjson/tests/unity/examples/example_1/test/TestProductionCode2.o 

C_DEPS += \
./src/cjson/tests/unity/examples/example_1/test/TestProductionCode.d \
./src/cjson/tests/unity/examples/example_1/test/TestProductionCode2.d 


# Each subdirectory must supply rules for building sources it contributes
src/cjson/tests/unity/examples/example_1/test/%.o: ../src/cjson/tests/unity/examples/example_1/test/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../zynq_rtos_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


