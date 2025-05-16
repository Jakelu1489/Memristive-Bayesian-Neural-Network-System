################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/tdc_dma/dma_thread.c \
../src/tdc_dma/mem_cache.c 

OBJS += \
./src/tdc_dma/dma_thread.o \
./src/tdc_dma/mem_cache.o 

C_DEPS += \
./src/tdc_dma/dma_thread.d \
./src/tdc_dma/mem_cache.d 


# Each subdirectory must supply rules for building sources it contributes
src/tdc_dma/%.o: ../src/tdc_dma/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../zynq_rtos_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


