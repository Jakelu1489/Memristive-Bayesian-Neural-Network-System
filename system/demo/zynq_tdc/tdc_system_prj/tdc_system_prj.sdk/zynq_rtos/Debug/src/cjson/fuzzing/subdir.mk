################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/cjson/fuzzing/afl.c \
../src/cjson/fuzzing/cjson_read_fuzzer.c \
../src/cjson/fuzzing/fuzz_main.c 

OBJS += \
./src/cjson/fuzzing/afl.o \
./src/cjson/fuzzing/cjson_read_fuzzer.o \
./src/cjson/fuzzing/fuzz_main.o 

C_DEPS += \
./src/cjson/fuzzing/afl.d \
./src/cjson/fuzzing/cjson_read_fuzzer.d \
./src/cjson/fuzzing/fuzz_main.d 


# Each subdirectory must supply rules for building sources it contributes
src/cjson/fuzzing/%.o: ../src/cjson/fuzzing/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../zynq_rtos_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


