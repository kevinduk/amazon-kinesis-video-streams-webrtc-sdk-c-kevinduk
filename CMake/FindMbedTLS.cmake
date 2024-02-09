include(CMakePrintHelpers)
message("In FindMbedTLS.cmake")
find_path(MBEDTLS_INCLUDE_DIRS mbedtls/ssl.h)
cmake_print_variables(MBEDTLS_INCLUDE_DIRS)

cmake_print_variables(MBEDTLS_LIBRARY)
cmake_print_variables(MBEDX509_LIBRARY)
cmake_print_variables(MBEDCRYPTO_LIBRARY)
cmake_print_variables(CMAKE_FIND_LIBRARY_PREFIXES)
cmake_print_variables(CMAKE_FIND_LIBRARY_SUFFIXES)

message("HINTS: ${OPEN_SRC_INSTALL_PREFIX}")

cmake_print_variables(OPEN_SRC_INSTALL_PREFIX)
find_library(MBEDTLS_LIBRARY NAMES mbedtls libmbedtls.a HINTS ${OPEN_SRC_INSTALL_PREFIX})

cmake_print_variables(MBEDTLS_LIBRARY)
find_library(MBEDX509_LIBRARY libmbedx509.a)
cmake_print_variables(MBEDX509_LIBRARY)
find_library(MBEDCRYPTO_LIBRARY libmbedcrypto.a)
cmake_print_variables(MBEDCRYPTO_LIBRARY)

set(MBEDTLS_LIBRARIES "${MBEDTLS_LIBRARY}" "${MBEDX509_LIBRARY}" "${MBEDCRYPTO_LIBRARY}")
cmake_print_variables(MBEDTLS_LIBRARIES)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MbedTLS DEFAULT_MSG
    MBEDTLS_LIBRARY MBEDTLS_INCLUDE_DIRS MBEDX509_LIBRARY MBEDCRYPTO_LIBRARY)

mark_as_advanced(MBEDTLS_INCLUDE_DIRS MBEDTLS_LIBRARY MBEDX509_LIBRARY MBEDCRYPTO_LIBRARY)

if(NOT TARGET MbedTLS)
	message("in mbedtls ${MBEDTLS_LIBRARY}")
    add_library(MbedTLS UNKNOWN IMPORTED)
    set_target_properties(MbedTLS PROPERTIES
                          INTERFACE_INCLUDE_DIRECTORIES "${MBEDTLS_INCLUDE_DIRS}"
                          IMPORTED_LINK_INTERFACE_LANGUAGES "C"
                          IMPORTED_LOCATION "${MBEDTLS_LIBRARY}")
endif()

if(NOT TARGET MbedCrypto)
    add_library(MbedCrypto UNKNOWN IMPORTED)
    set_target_properties(MbedCrypto PROPERTIES
                          INTERFACE_INCLUDE_DIRECTORIES "${MBEDTLS_INCLUDE_DIRS}"
                          IMPORTED_LINK_INTERFACE_LANGUAGES "C"
                          IMPORTED_LOCATION "${MBEDCRYPTO_LIBRARY}")
endif()

if(NOT TARGET MbedX509)
    add_library(MbedX509 UNKNOWN IMPORTED)
    set_target_properties(MbedX509 PROPERTIES
                          INTERFACE_INCLUDE_DIRECTORIES "${MBEDTLS_INCLUDE_DIRS}"
                          IMPORTED_LINK_INTERFACE_LANGUAGES "C"
                          IMPORTED_LOCATION "${MBEDX509_LIBRARY}")
endif()
