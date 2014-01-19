#
# GCovUtilities.cmake
#
# Utility functions enable test coverage and profiling
# information, as well as a mechanism
#
# See LICENCE.md for Copyright information.

find_program (GCOV_EXECUTABLE gcov)

if (GCOV_EXECUTABLE)

    mark_as_advanced (GCOV_EXECUTABLE)

else (GCOV_EXECUTABLE)

    message (STATUS "GCov was not found, coverage reports will not be enabled")
    return ()

endif (GCOV_EXECUTABLE)

if (NOT CMAKE_COMPILER_IS_GNUCXX OR NOT CMAKE_COMPILER_IS_GNUCC)

    message (STATUS "Compiler is not gcc or g++, coverage reports will not be "
                    "enabled")

endif (NOT CMAKE_COMPILER_IS_GNUCXX OR NOT CMAKE_COMPILER_IS_GNUCC)

option (ENABLE_COVERAGE "Enable code coverage data generation" OFF)
option (ENABLE_PROFILING "Enable code profiling data generation" OFF)

set (FORCE_DEBUG_SYMBOLS_AND_NOOPT OFF)

if (ENABLE_COVERAGE OR ENABLE_PROFILING)

    set (FORCE_DEBUG_SYMBOLS_AND_NOOPT ON)

endif (ENABLE_COVERAGE OR ENABLE_PROFILING)

if (FORCE_DEBUG_SYMBOLS_AND_NOOPT)

    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O0")
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O0")

endif (FORCE_DEBUG_SYMBOLS_AND_NOOPT)

if (ENABLE_COVERAGE)

    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ftest-coverage")
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -ftest-coverage")

    message (STATUS "Code coverage reporting enabled")

endif (ENABLE_COVERAGE)

if (ENABLE_PROFILING)

    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-arcs")
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fprofile-arcs")

    message (STATUS "Code profiling counters enabled")

endif (ENABLE_PROFILING)
