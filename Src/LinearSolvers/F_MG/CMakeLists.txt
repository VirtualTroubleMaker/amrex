# -*- mode: cmake -*-

include(TestManager)

#
# Define a project name
# After this command the following variables are defined
#   FMG_SOURCE_DIR
#   FMG_BINARY_DIR
# Other projects (subdirectories) can reference this directory
# through these variables.
project(FMG)

include_directories(${FBOXLIB_INCLUDE_DIRS})

include_directories(${CMAKE_FORTRAN_MODULE_DIRECTORY})

set(F90_source_files bc_functions.f90 coarsen_coeffs.f90 mg_prolongation.f90 ml_prolongation.f90 cc_mg_cpp.f90 cc_applyop.f90 cc_ml_resid.f90 cc_smoothers.f90 cc_restriction.f90 cc_stencil.f90 cc_stencil_apply.f90 cc_stencil_fill.f90 cc_interface_stencil.f90 itsol.f90 ml_restriction.f90 mg.f90 mg_tower.f90 ml_cc.f90 ml_nd.f90 ml_norm.f90 edge_restriction.f90 tridiag.f90 nodal_mg_cpp.f90 nodal_neumann_bcs.f90 nodal_mask.f90 nodal_divu.f90 nodal_interface_stencil.f90 nodal_newu.f90 nodal_restriction.f90 nodal_stencil.f90 nodal_stencil_fill.f90 nodal_smoothers.f90 nodal_mg_cpp.f90)

set(C_header_files mg_cpp_f.h)
set(CXX_header_files)
set(F77_header_files)
set(FPP_header_files)
set(F90_header_files)

preprocess_boxlib_fortran(FPP_out_files ${FPP_source_files})

set(local_source_files ${CXX_source_files} ${F77_source_files} ${FPP_out_files} ${F90_source_files})
set(local_header_files ${C_header_files} ${CXX_header_files} ${F77_header_files} ${FPP_header_files} ${F90_header_files})
add_library(box_fmg ${local_source_files})

# The following line ensures that the mod files associated with the base lib will be build in time
#  and tell CMake that anything that links to fmg must link to fboxlib.
target_link_libraries(box_fmg box_f)

add_install_include_file(${local_header_files})
add_install_library(box_fmg)

if (BUILD_TESTS AND BL_SPACEDIM EQUAL 3)
endif()
   