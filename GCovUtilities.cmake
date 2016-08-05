# /GCovUtilities.cmake
#
# Utility options enable test coverage and profiling information.
#
# See /LICENCE.md for Copyright information
include ("cmake/cmake-include-guard/IncludeGuard")
cmake_include_guard (SET_MODULE_PATH)

find_program (GCOV_EXECUTABLE gcov)

if (GCOV_EXECUTABLE)

    mark_as_advanced (GCOV_EXECUTABLE)

endif ()

option (ENABLE_COVERAGE "Enable code coverage data generation" OFF)
option (ENABLE_PROFILING "Enable code profiling data generation" OFF)

# gcov_get_compile_flags
#
# Get the compiler flags to enable C++ code coverage reports
#
# RETURN_COMPILE_FLAGS: A variable to store the compile flags in
# RETURN_LINK_FLAGS: A variable to store linker flags in
function (gcov_get_compile_flags RETURN_COMPILE_FLAGS
                                 RETURN_LINK_FLAGS)

    if (NOT CMAKE_COMPILER_IS_GNUCXX OR NOT CMAKE_COMPILER_IS_GNUCC)

        message (STATUS "Compiler is not gcc or g++, coverage "
                        "reports will not be enabled")
        return ()

    endif ()

    if (NOT GCOV_EXECUTABLE)

        message (STATUS "GCov was not found, coverage reports "
                        "will not be enabled")
        return ()

    endif ()

    if (ENABLE_COVERAGE OR ENABLE_PROFILING)

        set (COMPILE_FLAGS "-g -O0")

    endif ()

    if (ENABLE_COVERAGE)

        set (COMPILE_FLAGS "${COMPILE_FLAGS} -ftest-coverage -fprofile-arcs")
        set (LINK_FLAGS "-fprofile-arcs -lgcov")

    endif ()

    set (${RETURN_COMPILE_FLAGS} "${COMPILE_FLAGS}" PARENT_SCOPE)
    set (${RETURN_LINK_FLAGS} "${LINK_FLAGS}" PARENT_SCOPE)

endfunction ()
