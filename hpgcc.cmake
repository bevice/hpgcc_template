CMAKE_MINIMUM_REQUIRED(VERSION 3.6)
# Путь к тулчейну
if (DEFINED ENV{HPGCC_TOOLCHAIN_PATH})
    SET(TOOLCHAIN_DIR $ENV{HPGCC_TOOLCHAIN_PATH})
else ()
    message(FATAL_ERROR "Please set HPGCC_TOOLCHAIN_PATH environment value")
endif ()

set(CMAKE_SYSTEM_PROCESSOR ARM)
set(CMAKE_SYSTEM_NAME Generic)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)


# Другие полезные пути
SET(TOOLCHAIN_BIN_DIR ${TOOLCHAIN_DIR}/bin)
SET(TOOLCHAIN_LIB_DIR ${TOOLCHAIN_DIR}/lib)
SET(TOOLCHAIN_INC_DIR ${TOOLCHAIN_DIR}/include)


include_directories(${TOOLCHAIN_INC_DIR})
#link_directories(${TOOLCHAIN_LIB_DIR})

if (WIN32)
    SET(EXE_SUFFIX ".exe")
else ()
    SET(EXE_SUFFIX "")
endif ()
# Компиляторы
SET(CMAKE_C_COMPILER "${TOOLCHAIN_BIN_DIR}/arm-elf-gcc${EXE_SUFFIX}" CACHE INTERNAL "")
SET(CMAKE_CXX_COMPILER "${TOOLCHAIN_BIN_DIR}/arm-elf-g++${EXE_SUFFIX}" CACHE INTERNAL "")
SET(CMAKE_LINKER "${TOOLCHAIN_BIN_DIR}/arm-elf-ld${EXE_SUFFIX}" CACHE INTERNAL "")
SET(CMAKE_C_LINK_EXECUTABLE "<CMAKE_LINKER> -L${TOOLCHAIN_LIB_DIR} -T VCld.script <LINK_FLAGS>  ${TOOLCHAIN_LIB_DIR}/crt0.o <OBJECTS> -lhplib  -lgcc -lhpg <LINK_LIBRARIES> -o <TARGET> ")

# objcopy и objdump для создания хексов и бинариков
SET(CMAKE_OBJCOPY "${TOOLCHAIN_BIN_DIR}/arm-elf-objcopy${EXE_SUFFIX}" CACHE INTERNAL "")
SET(CMAKE_OBJDUMP "${TOOLCHAIN_BIN_DIR}/arm-elf-objdump${EXE_SUFFIX}" CACHE INTERNAL "")
SET(CMAKE_ELF2HP "${TOOLCHAIN_BIN_DIR}/elf2hp${EXE_SUFFIX}" CACHE INTERNAL "")
SET(CMAKE_SIZE "${TOOLCHAIN_BIN_DIR}/arm-elf-size${EXE_SUFFIX}" CACHE INTERNAL "")


# Флаги компиляторов, тут можно подкрутить
SET(CMAKE_C_FLAGS "-mtune=arm920t -mcpu=arm920t -mlittle-endian -fomit-frame-pointer -msoft-float -Wall -Os -mthumb-interwork -mthumb   -std=gnu99" CACHE INTERNAL "c compiler flags")
#SET(CMAKE_CXX_FLAGS "-mtune=arm920t -mcpu=arm920t -mlittle-endian -fomit-frame-pointer -msoft-float -Wall -Os -mthumb-interwork -mthumb " CACHE INTERNAL "cxx compiler flags")
SET(CMAKE_EXE_LINKER_FLAGS "-nodefaultlib -nostdlib -static" CACHE INTERNAL "exe link flags")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Флаги компилятора для разных типов сборки.
#SET(COMPILE_DEFINITIONS_DEBUG -O0 -g3 -DDEBUG)
#SET(COMPILE_DEFINITIONS_RELEASE -Os)
