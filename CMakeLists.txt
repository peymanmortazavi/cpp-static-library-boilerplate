cmake_minimum_required(VERSION 3.9)
project(MyLibrary VERSION 1.0.0 DESCRIPTION "Some description for my library.")
include(GNUInstallDirs)

set(CMAKE_CXX_STANDARD 11)

set(SOURCE_FILES src/library.cpp include/library.h src/private.h)
set(PUBLIC_HEADERS include/library.h)
add_library(${PROJECT_NAME} ${SOURCE_FILES})
set_target_properties(${PROJECT_NAME} PROPERTIES VERSION ${PROJECT_VERSION} PUBLIC_HEADER ${PUBLIC_HEADERS})
target_include_directories(${PROJECT_NAME} PRIVATE .)

set(CMAKE_SHARED_LINKER_FLAGS "-Wall")

IF(IOS)
    message(STATUS "iOS Toolchains Selected")
    include(${CMAKE_CURRENT_LIST_DIR}/platforms/ios/cmake/project.cmake)
ELSE()
    configure_file(mylib.pc.in mylib.pc @ONLY)
    install(TARGETS ${PROJECT_NAME}
            ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
            LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
            PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME})
    install(FILES ${CMAKE_BINARY_DIR}/mylib.pc DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/pkgconfig)
ENDIF()