# -*- mode: cmake -*-

# Require cmake 2.8 or higher
cmake_minimum_required(VERSION 2.8.2)

if ("${CMAKE_PATCH_VERSION}" GREATER 3)
  set(ADJUST_POLICY "True")
endif()

if (${ADJUST_POLICY})
  cmake_policy(SET CMP0017 NEW)
endif()

# Enable testing, ctest needs this
# all add_test commands are ignored unless this is called!
enable_testing()

# must be set prior to any project definition
if (ENABLE_MPI)
  set(CMAKE_C_COMPILER "${MPI_PREFIX}/bin/mpicc")
  set(CMAKE_CXX_COMPILER "${MPI_PREFIX}/bin/mpic++")
  set(CMAKE_Fortran_COMPILER "${MPI_PREFIX}/bin/mpif90")
endif()


# Useful variables pointing to directories in the source tree
set(CCSE_ROOT_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
set(CCSE_TOOLS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/Tools")
set(CCSE_PERL_DIR "${CCSE_TOOLS_DIR}/C_scripts")
set(CCSE_INSTALL_DIR "${CMAKE_CURRENT_SOURCE_DIR}/install")

# Set the module search path so find_package and include commands
# can locate files in <root source tree>/tools/cmake
set(CCSE_MODULE_PATH "${CCSE_TOOLS_DIR}/CMake")
set(CMAKE_MODULE_PATH  ${CCSE_MODULE_PATH})

# Addtional build options
include(CCSEOptions)

# A property for accumulating the a global CCSE link line.
set_property(GLOBAL PROPERTY AMANZI_LINK_LINE "-L${CMAKE_INSTALL_PREFIX}/lib")

# A property for accumulating CCSE library targets
set_property(GLOBAL PROPERTY CCSE_LIBRARY_TARGETS)
set(CCSE_LINK_LINE_FILE "${CMAKE_INSTALL_PREFIX}/lib/link_line")  # A filename to write link-line to.
include(InstallManager)


# Define the project name
# This command will define
#     CCSE_SOURCE_DIR
#     CCSE_BINARY_DIR
project(CCSE)

# Source files for all binaries and libraries found under src
add_subdirectory(Src)

# Make the exports only _after_ doing the build
create_exports()

if (${CCSE_INSTALL_DIR} STREQUAL ${CMAKE_CURRENT_SOURCE_DIR})
else ()
    install(FILES ${CCSE_PERL_DIR}/strip72
        DESTINATION ${CCSE_INSTALL_DIR}/perl)
endif ()

option(ENABLE_Config_Report "Print out detailed information at the end of a configuration")
set(CCSE_CONFIG_LOG "${CCSE_BINARY_DIR}/ccse-config.log"
    CACHE string "CCSE configuration log file")
include(CCSEConfigReport)
if (ENABLE_Config_Report)
    execute_process(COMMAND "${cat_exec}" "${CCSE_CONFIG_LOG}" OUTPUT_VARIABLE config_output)
    message(STATUS "contents of: ${CCSE_CONFIG_LOG}")
    message(STATUS "${config_output}")
endif()    
