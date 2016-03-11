# /CMakeLists.txt
#
# Main build file for cmake-forward-arguments
#
# See /LICENCE.md for Copyright information
include ("${CMAKE_CURRENT_LIST_DIR}/conanbuildinfo.cmake")
set (CMAKE_MODULE_PATH
     "${CMAKE_CURRENT_LIST_DIR}"
     ${CONAN_CMAKE_MODULE_PATH}  # NOLINT:correctness/quotes
     ${CMAKE_MODULE_PATH})  # NOLINT:correctness/quotes

cmake_minimum_required (VERSION 2.8)

include ("cmake/cmake-unit/CMakeUnit")
include ("cmake/cmake-unit/CMakeUnitRunner")
include (GCovUtilities)

function (gcov_test_no_test_coverage_if_cmake_compiler_not_gnucxx)

    function (gcov_configure)

        unset (CMAKE_COMPILER_IS_GNUCXX)  # NOLINT:unused/var_in_func
        unset (CMAKE_COMPILER_IS_GNUCC)  # NOLINT:unused/var_in_func

        gcov_get_compile_flags (FLAGS)

        cmake_unit_assert_that (FLAGS not variable_is STRING EQUAL
                                "-g -O0 -ftest-coverage -fprofile-arcs")

    endfunction ()

    cmake_unit_configure_config_only_test (CONFIGURE COMMAND gcov_configure)

endfunction ()

function (gcov_test_no_test_coverage_enable_coverage_not_set)

    function (gcov_configure)

        set (CMAKE_COMPILER_IS_GNUCXX ON)  # NOLINT:unused/var_in_func
        set (CMAKE_COMPILER_IS_GNUCC ON)  # NOLINT:unused/var_in_func

        set (ENABLE_COVERAGE OFF CACHE BOOL "" FORCE)

        gcov_get_compile_flags (FLAGS)

        cmake_unit_assert_that (FLAGS not compare_as STRING EQUAL
                                "-g -O0 -ftest-coverage -fprofile-arcs")

    endfunction ()

    cmake_unit_configure_config_only_test (CONFIGURE COMMAND gcov_configure)

endfunction ()

function (gcov_test_no_test_coverage_enable_coverage_not_set)

    function (gcov_configure)

        set (CMAKE_COMPILER_IS_GNUCXX ON)  # NOLINT:unused/var_in_func
        set (CMAKE_COMPILER_IS_GNUCC ON)  # NOLINT:unused/var_in_func

        set (ENABLE_COVERAGE OFF CACHE BOOL "" FORCE)

        gcov_get_compile_flags (FLAGS)

        cmake_unit_assert_that (FLAGS not compare_as STRING EQUAL
                                "-g -O0 -ftest-coverage -fprofile-arcs")

    endfunction ()

    cmake_unit_configure_config_only_test (CONFIGURE COMMAND gcov_configure)

endfunction ()

function (gcov_test_enable_coverage_if_set)

    function (gcov_configure)

        set (CMAKE_COMPILER_IS_GNUCXX ON)  # NOLINT:unused/var_in_func
        set (CMAKE_COMPILER_IS_GNUCC ON)  # NOLINT:unused/var_in_func

        set (ENABLE_COVERAGE ON CACHE BOOL "" FORCE)

        gcov_get_compile_flags (FLAGS)

        cmake_unit_assert_that (FLAGS compare_as STRING EQUAL
                                "-g -O0 -ftest-coverage -fprofile-arcs")

    endfunction ()

    cmake_unit_configure_config_only_test (CONFIGURE COMMAND gcov_configure)

endfunction ()

function (gcov_test_enable_debug_if_profiling_set)

    function (gcov_configure)

        set (CMAKE_COMPILER_IS_GNUCXX ON)  # NOLINT:unused/var_in_func
        set (CMAKE_COMPILER_IS_GNUCC ON)  # NOLINT:unused/var_in_func

        set (ENABLE_PROFILING ON CACHE BOOL "" FORCE)

        gcov_get_compile_flags (FLAGS)

        cmake_unit_assert_that (FLAGS compare_as STRING EQUAL
                                "-g -O0")

    endfunction ()

    cmake_unit_configure_config_only_test (CONFIGURE COMMAND gcov_configure)

endfunction ()

cmake_unit_init (NAMESPACE gcov
                 COVERAGE_FILES "${CMAKE_CURRENT_LIST_DIR}/GCovUtilities.cmake")
