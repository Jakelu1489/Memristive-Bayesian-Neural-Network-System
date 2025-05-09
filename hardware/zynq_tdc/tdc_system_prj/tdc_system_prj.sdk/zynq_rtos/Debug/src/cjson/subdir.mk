################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/cjson/cJSON.c \
../src/cjson/cJSON_Utils.c 

OBJS += \
./src/cjson/cJSON.o \
./src/cjson/cJSON_Utils.o 

C_DEPS += \
./src/cjson/cJSON.d \
./src/cjson/cJSON_Utils.d 


# Each subdirectory must supply rules for building sources it contributes
src/cjson/%.o: ../src/cjson/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../zynq_rtos_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


