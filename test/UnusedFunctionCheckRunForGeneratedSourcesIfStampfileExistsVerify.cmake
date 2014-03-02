# /test/UnusedFunctionCheckRunForGeneratedSourcesIfStampfileExistsVerify.cmake
# Check that the unused function check is run on this instance - e.g., that
# we needed to generate some files or that files became out of date even though
# the stampfile already exists.
#
# See LICENCE.md for Copyright information.

include (${CPPCHECK_COMMON_UNIVERSAL_CMAKE_DIRECTORY}/CPPCheck.cmake)
include (${CPPCHECK_COMMON_UNIVERSAL_CMAKE_TESTS_DIRECTORY}/CMakeUnit.cmake)

set (BUILD_OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/BUILD.output)

# First make sure that our files were generated as the build rule requires.
assert_file_has_line_matching (${BUILD_OUTPUT}
                               "^.*Generating.*Generated\\.cpp.*$")

# Now make sure that the cppcheck rule was run
set (UNUSED_FUNCTION_REGEX
     "^.*cppcheck.*unusedFunction.*Generated\\.cpp.*$")
assert_file_has_line_matching (${BUILD_OUTPUT}
                               ${UNUSED_FUNCTION_REGEX})