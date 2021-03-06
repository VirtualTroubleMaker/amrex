###############################################

# Here we define all the global variable that #
# will be used in the CMake files

###############################################

#
# Check if project() has been called; abort if not
# 
if ( NOT PROJECT_NAME )
   message ( FATAL_ERROR "AMReX_CMakeVariables.cmake cannot be included\
before calling project()" )
endif ()

# Add variables for AMReX versioning 



# Set paths for build system
set ( CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/Src/mod_files )


# Set directory paths
set (AMREX_SOURCE_DIR       ${CMAKE_SOURCE_DIR}/Src )
set (AMREX_LIBRARY_DIR      ${CMAKE_INSTALL_PREFIX}/lib )
set (AMREX_INCLUDE_DIR      ${CMAKE_INSTALL_PREFIX}/include )
set (AMREX_BINARY_DIR       ${CMAKE_INSTALL_PREFIX}/bin )
set (AMREX_LIBRARIES        fboxlib;cboxlib;fboxlib;cfboxlib;box_camrdata)


# The following is the old way: why cache?
# set ( CMAKE_Fortran_MODULE_DIRECTORY
#    ${CMAKE_CURRENT_BINARY_DIR}/mod_files
#    CACHE PATH "Folder for fortran module files")

# The type of build ( will need to be uppercase )
set ( AMREX_BUILD_TYPE )

# Whether AMReX_Options.cmake has been included already
if ( NOT AMREX_OPTIONS_SET )
   set ( AMREX_OPTIONS_SET )
endif ()

# Flags to accumulate preprocessor directives
set ( AMREX_DEFINES ) 

# Shorter-name variables for the compilers id
set ( FC_ID ${CMAKE_Fortran_COMPILER_ID} )
set ( CC_ID ${CMAKE_C_COMPILER_ID} )
set ( CXX_ID ${CMAKE_CXX_COMPILER_ID} )

# Compiler flags
set ( AMREX_Fortran_FLAGS )
set ( AMREX_C_FLAGS )
set ( AMREX_CXX_FLAGS )

# GNU compiler specific flags
set (AMREX_GNU_FFLAGS_DEBUG "-g -O0 -ggdb -fbounds-check -fbacktrace\
 -Wuninitialized -Wunused -ffpe-trap=invalid,zero -finit-real=snan\
 -finit-integer=2147483647 -ftrapv")
set (AMREX_GNU_FFLAGS_RELEASE "-O3 -DNDEBUG")
set (AMREX_GNU_FFLAGS_REQUIRED "-ffixed-line-length-none -ffree-line-length-none\
 -fno-range-check -fno-second-underscore")

set (AMREX_GNU_CXXFLAGS_DEBUG "-g -O0 -fno-inline -ggdb -Wall -Wno-sign-compare -ftrapv")
set (AMREX_GNU_CXXFLAGS_RELEASE "-O3 -DNDEBUG")
set (AMREX_GNU_CXXFLAGS_REQUIRED "") #-ftemplate-depth-64 -Wno-deprecated")

# Intel compiler specific flags
set (AMREX_Intel_FFLAGS_DEBUG "-g -O0 -traceback -check bounds,uninit,pointers")
set (AMREX_Intel_FFLAGS_RELEASE "-O2 -ip -qopt-report=5 -qopt-report-phase=vec")
set (AMREX_Intel_FFLAGS_REQUIRED "-extend_source")

set (AMREX_Intel_CXXFLAGS_DEBUG "-g -O0 -traceback -Wcheck")
set (AMREX_Intel_CXXFLAGS_RELEASE "-O2 -ip -qopt-report=5 -qopt-report-phase=vec")
set (AMREX_Intel_CXXFLAGS_REQUIRED "")#-ftemplate-depth-64 -Wno-deprecated")

# PGI compiler specific flags
set (AMREX_PGI_FFLAGS_DEBUG "-O0 -Mbounds -Ktrap=divz,inv -Mchkptr")
set (AMREX_PGI_FFLAGS_RELEASE "-gopt -fast")
set (AMREX_PGI_FFLAGS_REQUIRED "-extend")

set (AMREX_PGI_CXXFLAGS_DEBUG "-O0 -Mbounds")
set (AMREX_PGI_CXXFLAGS_RELEASE "-gopt -fast")
set (AMREX_PGI_CXXFLAGS_REQUIRED "")#-ftemplate-depth-64 -Wno-deprecated")


# Cray compiler specific flags
set (AMREX_Cray_FFLAGS_DEBUG "-O0 -e -i")
set (AMREX_Cray_FFLAGS_RELEASE "-02")
set (AMREX_Cray_FFLAGS_REQUIRED "-extend")

set (AMREX_Cray_CXXFLAGS_DEBUG "-O0")
set (AMREX_Cray_CXXFLAGS_RELEASE "-02")
set (AMREX_Cray_CXXFLAGS_REQUIRED "")#-ftemplate-depth-64 -Wno-deprecated")

#
# Compile- and link-time variables 
#
set (AMREX_EXTRA_C_INCLUDE_PATH)
set (AMREX_EXTRA_CXX_INCLUDE_PATH)
set (AMREX_EXTRA_Fortran_INCLUDE_PATH)
set (AMREX_EXTRA_C_FLAGS)
set (AMREX_EXTRA_CXX_FLAGS)
set (AMREX_EXTRA_Fortran_FLAGS)
set (AMREX_EXTRA_C_LIBRARIES)
set (AMREX_EXTRA_CXX_LIBRARIES)
set (AMREX_EXTRA_Fortran_LIBRARIES)
set (AMREX_EXTRA_C_LINK_FLAGS)
set (AMREX_EXTRA_CXX_LINK_FLAGS)
set (AMREX_EXTRA_Fortran_LINK_FLAGS)
set (AMREX_EXTRA_C_LINK_LINE)
set (AMREX_EXTRA_CXX_LINK_LINE)
set (AMREX_EXTRA_Fortran_LINK_LINE)

# Variable to show this file was loaded
set ( AMREX_VARIABLES_LOADED "TRUE" )
