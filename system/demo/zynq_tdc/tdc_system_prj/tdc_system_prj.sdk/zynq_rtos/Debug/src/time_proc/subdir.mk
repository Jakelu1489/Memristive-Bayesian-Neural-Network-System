################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/time_proc/calibLookupTab.c \
../src/time_proc/time_cal.c 

OBJS += \
./src/time_proc/calibLookupTab.o \
./src/time_proc/time_cal.o 

C_DEPS += \
./src/time_proc/calibLookupTab.d \
./src/time_proc/time_cal.d 


# Each subdirectory must supply rules for building sources it contributes
src/time_proc/%.o: ../src/time_proc/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../zynq_rtos_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


