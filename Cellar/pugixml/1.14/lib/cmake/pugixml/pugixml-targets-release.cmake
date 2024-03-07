#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "pugixml::shared" for configuration "Release"
set_property(TARGET pugixml::shared APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(pugixml::shared PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libpugixml.1.14.dylib"
  IMPORTED_SONAME_RELEASE "@rpath/libpugixml.1.dylib"
  )

list(APPEND _cmake_import_check_targets pugixml::shared )
list(APPEND _cmake_import_check_files_for_pugixml::shared "${_IMPORT_PREFIX}/lib/libpugixml.1.14.dylib" )

# Import target "pugixml::static" for configuration "Release"
set_property(TARGET pugixml::static APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(pugixml::static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libpugixml.a"
  )

list(APPEND _cmake_import_check_targets pugixml::static )
list(APPEND _cmake_import_check_files_for_pugixml::static "${_IMPORT_PREFIX}/lib/libpugixml.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
