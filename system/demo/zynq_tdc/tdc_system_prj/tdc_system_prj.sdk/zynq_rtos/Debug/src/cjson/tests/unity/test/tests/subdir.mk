################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/cjson/tests/unity/test/tests/testparameterized.c \
../src/cjson/tests/unity/test/tests/testunity.c 

OBJS += \
./src/cjson/tests/unity/test/tests/testparameterized.o \
./src/cjson/tests/unity/test/tests/testunity.o 

C_DEPS += \
./src/cjson/tests/unity/test/tests/testparameterized.d \
./src/cjson/tests/unity/test/tests/testunity.d 


# Each subdirectory must supply rules for building sources it contributes
src/cjson/tests/unity/test/tests/%.o: ../src/cjson/tests/unity/test/tests/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../zynq_rtos_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


