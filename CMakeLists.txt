project(qterm)
include(CTest)
include(FeatureSummary)
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)
set(QTERM_VERSION_MAJOR 0)
set(QTERM_VERSION_MINOR 7)
set(QTERM_VERSION_RELEASE 3)
set(QTERM_VERSION "${QTERM_VERSION_MAJOR}.${QTERM_VERSION_MINOR}.${QTERM_VERSION_RELEASE}" )
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
set(QT_MIN_VERSION "5.9.0")
set(KF5_MIN_VERSION "5.46.0")

set(CMAKE_AUTOMOC ON)
find_package(Qt5 ${QT_MIN_VERSION} REQUIRED COMPONENTS
        Core
        Gui
        Widgets
        Xml
        Network
        PrintSupport
        LinguistTools
        Help
    OPTIONAL_COMPONENTS
        DBus
        Script
        ScriptTools
        Multimedia
    )

find_package (ECM NO_MODULE)
if(ECM_FOUND)
    set (CMAKE_MODULE_PATH
        ${CMAKE_MODULE_PATH}
        ${ECM_MODULE_PATH}
        ${ECM_KDE_MODULE_DIR}
    )
    include(KDEInstallDirs)
    include(KDECMakeSettings)
    find_package (KF5 COMPONENTS
        Wallet
        WindowSystem)
endif(ECM_FOUND)

find_package(Phonon4Qt5)

IF(WIN32 AND MSVC)
    ADD_DEFINITIONS (/D _CRT_SECURE_NO_WARNINGS)
ENDIF(WIN32 AND MSVC)

IF(APPLE)
   SET (PROGRAME QTerm)
   SET (MACOSX_BUNDLE_BUNDLE_NAME ${PROGRAME})
   SET (MACOSX_BUNDLE_GUI_IDENTIFIER "org.qterm")
   SET (MACOSX_BUNDLE_INFO_STRING "${PROGRAME} ${QTERM_VERSION}")
   SET (MACOSX_BUNDLE_BUNDLE_VERSION ${QTERM_VERSION})
   SET (MACOSX_BUNDLE_LONG_VERSION_STRING ${QTERM_VERSION})
   SET (MACOSX_BUNDLE_SHORT_VERSION_STRING "${QTERM_VERSION_MAJOR}.${QTERM_VERSION_MINOR}")
   SET (MACOSX_BUNDLE_ICON_FILE QTerm.icns)
   SET (MACOSX_BUNDLE_COPYRIGHT "The QTerm Project")
ELSE(APPLE)
   SET (PROGRAME qterm)
ENDIF(APPLE)

include("package.cmake")
add_subdirectory(src)
add_subdirectory(icons)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config.h)

configure_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake_uninstall.cmake.in"
  "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
  IMMEDIATE @ONLY)
if (NOT TARGET uninstall)
    add_custom_target(uninstall
      "${CMAKE_COMMAND}" -P "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake")
endif(NOT TARGET uninstall)
feature_summary(WHAT ALL)
