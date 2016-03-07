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

else ()

    message (STATUS "GCov was not found, coverage reports will not be enabled")
    return ()

endif ()

if (NOT CMAKE_COMPILER_IS_GNUCXX OR NOT CMAKE_COMPILER_IS_GNUCC)

    message (STATUS "Compiler is not gcc or g++, coverage reports will not be "
                    "enabled")
    return ()

endif ()

option (ENABLE_COVERAGE "Enable code coverage data generation" OFF)
option (ENABLE_PROFILING "Enable code profiling data generation" OFF)

set (FORCE_DEBUG_SYMBOLS_AND_NOOPT OFF)

if (ENABLE_COVERAGE OR ENABLE_PROFILING)

    set (FORCE_DEBUG_SYMBOLS_AND_NOOPT ON)

endif ()

if (FORCE_DEBUG_SYMBOLS_AND_NOOPT)

    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O0")
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O0")

endif ()

if (ENABLE_COVERAGE)

    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ftest-coverage -fprofile-arcs")
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -ftest-coverage -fprofile-arcs")

    message (STATUS "Code coverage and profiling counters enabled")

endif ()
