# A Modified Version of FindOpenSSL.cmake from CMake 2.6.2
# Because we only need the crypto library for QTerm

# - Try to find the OpenSSL encryption library
# Once done this will define
#
#  OPENSSL_FOUND - system has the OpenSSL library
#  OPENSSL_INCLUDE_DIR - the OpenSSL include directory
#  OPENSSL_LIBRARIES - The libraries needed to use OpenSSL

# Copyright (c) 2006, Alexander Neundorf, <neundorf@kde.org>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.


IF(OPENSSL_CRYPTO_LIBRARIES)
   SET(OpenSSL_CRYPTO_FIND_QUIETLY TRUE)
ENDIF(OPENSSL_CRYPTO_LIBRARIES)

IF(LIB_EAY_DEBUG AND LIB_EAY_RELEASE)
   SET(LIB_FOUND 1)
ENDIF(LIB_EAY_DEBUG AND LIB_EAY_RELEASE)

FIND_PATH(OPENSSL_CRYPTO_INCLUDE_DIR openssl/ssl.h )

IF(WIN32 AND MSVC)
   # Not sure if this will work or not, since MSVC can not be used to
   # compile QTerm
   # /MD and /MDd are the standard values - if somone wants to use
   # others, the libnames have to change here too
   # use also ssl and ssleay32 in debug as fallback for openssl < 0.9.8b

   FIND_LIBRARY(LIB_EAY_DEBUG NAMES libeay32MDd libeay libeay32)
   FIND_LIBRARY(LIB_EAY_RELEASE NAMES libeay32MD libeay libeay32)

   IF(MSVC_IDE)
      IF(LIB_EAY_DEBUG AND LIB_EAY_RELEASE)
         SET(OPENSSL_CRYPTO_LIBRARIES optimized ${LIB_EAY_RELEASE} debug ${LIB_EAY_DEBUG})
      ELSE(LIB_EAY_DEBUG AND LIB_EAY_RELEASE)
         SET(OPENSSL_CRYPTO_LIBRARIES NOTFOUND)
         MESSAGE(STATUS "Could not find the debug and release version of openssl")
      ENDIF(LIB_EAY_DEBUG AND LIB_EAY_RELEASE)
   ELSE(MSVC_IDE)
      STRING(TOLOWER ${CMAKE_BUILD_TYPE} CMAKE_BUILD_TYPE_TOLOWER)
      IF(CMAKE_BUILD_TYPE_TOLOWER MATCHES debug)
         SET(OPENSSL_CRYPTO_LIBRARIES ${LIB_EAY_DEBUG})
      ELSE(CMAKE_BUILD_TYPE_TOLOWER MATCHES debug)
         SET(OPENSSL_CRYPTO_LIBRARIES ${LIB_EAY_RELEASE})
      ENDIF(CMAKE_BUILD_TYPE_TOLOWER MATCHES debug)
   ENDIF(MSVC_IDE)
   MARK_AS_ADVANCED(LIB_EAY_DEBUG LIB_EAY_RELEASE)
ELSE(WIN32 AND MSVC)
   IF (APPLE)
       FIND_LIBRARY(OPENSSL_CRYPTO_LIBRARIES
           NAMES crypto libeay32
           PATHS /opt/local/lib /usr/local/lib
           NO_DEFAULT_PATH)
   ELSE(APPLE)
       FIND_LIBRARY(OPENSSL_CRYPTO_LIBRARIES NAMES crypto libeay32)
   ENDIF(APPLE)
ENDIF(WIN32 AND MSVC)

IF(OPENSSL_CRYPTO_INCLUDE_DIR AND OPENSSL_CRYPTO_LIBRARIES)
   SET(OPENSSL_CRYPTO_FOUND TRUE)
ELSE(OPENSSL_CRYPTO_INCLUDE_DIR AND OPENSSL_CRYPTO_LIBRARIES)
   SET(OPENSSL_CRYPTO_FOUND FALSE)
ENDIF (OPENSSL_CRYPTO_INCLUDE_DIR AND OPENSSL_CRYPTO_LIBRARIES)

IF (OPENSSL_CRYPTO_FOUND)
   IF (NOT OpenSSL_CRYPTO_FIND_QUIETLY)
      MESSAGE(STATUS "Found OpenSSL Crypto Library: ${OPENSSL_CRYPTO_LIBRARIES}")
   ENDIF (NOT OpenSSL_CRYPTO_FIND_QUIETLY)
ELSE (OPENSSL_CRYPTO_FOUND)
   IF (OpenSSL_CRYPTO_FIND_REQUIRED)
      MESSAGE(FATAL_ERROR "Could NOT find OpenSSL")
   ENDIF (OpenSSL_CRYPTO_FIND_REQUIRED)
ENDIF (OPENSSL_CRYPTO_FOUND)

MARK_AS_ADVANCED(OPENSSL_CRYPTO_INCLUDE_DIR OPENSSL_CRYPTO_LIBRARIES)

