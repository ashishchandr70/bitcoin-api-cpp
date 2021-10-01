# Check if install manifest exists
IF(NOT EXISTS "/usr/local/src/CodeRepos/bitcoin-api-cpp/build/install_manifest.txt")
    MESSAGE(FATAL_ERROR "Cannot find install manifest: \"/usr/local/src/CodeRepos/bitcoin-api-cpp/build/install_manifest.txt\"")
ENDIF(NOT EXISTS "/usr/local/src/CodeRepos/bitcoin-api-cpp/build/install_manifest.txt")

# Read install manifest
FILE(READ "/usr/local/src/CodeRepos/bitcoin-api-cpp/build/install_manifest.txt" files)
STRING(REGEX REPLACE "\n" ";" files "${files}")
LIST(REVERSE files)

FOREACH(file ${files})
    MESSAGE(STATUS "Uninstalling \"${file}\"")
    IF(EXISTS "$ENV{DESTDIR}${file}")

        EXECUTE_PROCESS(
            COMMAND /usr/bin/cmake -E remove "$ENV{DESTDIR}${file}"
            OUTPUT_VARIABLE rm_out
            RESULT_VARIABLE rm_retval
        )

        IF(NOT ${rm_retval} EQUAL 0)
            MESSAGE(FATAL_ERROR "Problem when removing \"$ENV{DESTDIR}${file}\"")
        ENDIF(NOT ${rm_retval} EQUAL 0)

    ELSE(EXISTS "$ENV{DESTDIR}${file}")
        MESSAGE(STATUS "File \"$ENV{DESTDIR}${file}\" does not exist.")
    ENDIF(EXISTS "$ENV{DESTDIR}${file}")
ENDFOREACH(file)
