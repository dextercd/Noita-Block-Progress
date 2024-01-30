cmake_minimum_required(VERSION 3.24)

project(BlockProgress
    VERSION 0.1.0
    DESCRIPTION "Block most Noita progress and unlocks"
    HOMEPAGE_URL "https://github.com/dextercd/Noita-Block-Progress"
    LANGUAGES
)

install(DIRECTORY BlockProgress
    DESTINATION .
    COMPONENT BlockProgress
)

set(CPACK_GENERATOR ZIP)
set(CPACK_INCLUDE_TOPLEVEL_DIRECTORY FALSE)
set(CPACK_PACKAGE_FILE_NAME "${PROJECT_NAME}-${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}")
set(CPACK_VERBATIM_VARIABLES TRUE)
include(CPack)
