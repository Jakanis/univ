# CMAKE generated file: DO NOT EDIT!
# Generated by "MinGW Makefiles" Generator, CMake Version 3.15

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

SHELL = cmd.exe

# The CMake executable.
CMAKE_COMMAND = C:\Users\varmi\AppData\Local\JetBrains\Toolbox\apps\CLion\ch-0\193.6015.37\bin\cmake\win\bin\cmake.exe

# The command to remove a file.
RM = C:\Users\varmi\AppData\Local\JetBrains\Toolbox\apps\CLion\ch-0\193.6015.37\bin\cmake\win\bin\cmake.exe -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = D:\dev\Univ\Univ-4.2\Fundametal_mathematical_data_protection\Lab2\lab2-cpp

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = D:\dev\Univ\Univ-4.2\Fundametal_mathematical_data_protection\Lab2\lab2-cpp\cmake-build-release

# Include any dependencies generated for this target.
include CMakeFiles/lab2_cpp.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/lab2_cpp.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/lab2_cpp.dir/flags.make

CMakeFiles/lab2_cpp.dir/main.cpp.obj: CMakeFiles/lab2_cpp.dir/flags.make
CMakeFiles/lab2_cpp.dir/main.cpp.obj: ../main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=D:\dev\Univ\Univ-4.2\Fundametal_mathematical_data_protection\Lab2\lab2-cpp\cmake-build-release\CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/lab2_cpp.dir/main.cpp.obj"
	C:\lib\MinGW\bin\g++.exe  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\lab2_cpp.dir\main.cpp.obj -c D:\dev\Univ\Univ-4.2\Fundametal_mathematical_data_protection\Lab2\lab2-cpp\main.cpp

CMakeFiles/lab2_cpp.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/lab2_cpp.dir/main.cpp.i"
	C:\lib\MinGW\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E D:\dev\Univ\Univ-4.2\Fundametal_mathematical_data_protection\Lab2\lab2-cpp\main.cpp > CMakeFiles\lab2_cpp.dir\main.cpp.i

CMakeFiles/lab2_cpp.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/lab2_cpp.dir/main.cpp.s"
	C:\lib\MinGW\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S D:\dev\Univ\Univ-4.2\Fundametal_mathematical_data_protection\Lab2\lab2-cpp\main.cpp -o CMakeFiles\lab2_cpp.dir\main.cpp.s

# Object files for target lab2_cpp
lab2_cpp_OBJECTS = \
"CMakeFiles/lab2_cpp.dir/main.cpp.obj"

# External object files for target lab2_cpp
lab2_cpp_EXTERNAL_OBJECTS =

lab2_cpp.exe: CMakeFiles/lab2_cpp.dir/main.cpp.obj
lab2_cpp.exe: CMakeFiles/lab2_cpp.dir/build.make
lab2_cpp.exe: CMakeFiles/lab2_cpp.dir/linklibs.rsp
lab2_cpp.exe: CMakeFiles/lab2_cpp.dir/objects1.rsp
lab2_cpp.exe: CMakeFiles/lab2_cpp.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=D:\dev\Univ\Univ-4.2\Fundametal_mathematical_data_protection\Lab2\lab2-cpp\cmake-build-release\CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable lab2_cpp.exe"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles\lab2_cpp.dir\link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/lab2_cpp.dir/build: lab2_cpp.exe

.PHONY : CMakeFiles/lab2_cpp.dir/build

CMakeFiles/lab2_cpp.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles\lab2_cpp.dir\cmake_clean.cmake
.PHONY : CMakeFiles/lab2_cpp.dir/clean

CMakeFiles/lab2_cpp.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" D:\dev\Univ\Univ-4.2\Fundametal_mathematical_data_protection\Lab2\lab2-cpp D:\dev\Univ\Univ-4.2\Fundametal_mathematical_data_protection\Lab2\lab2-cpp D:\dev\Univ\Univ-4.2\Fundametal_mathematical_data_protection\Lab2\lab2-cpp\cmake-build-release D:\dev\Univ\Univ-4.2\Fundametal_mathematical_data_protection\Lab2\lab2-cpp\cmake-build-release D:\dev\Univ\Univ-4.2\Fundametal_mathematical_data_protection\Lab2\lab2-cpp\cmake-build-release\CMakeFiles\lab2_cpp.dir\DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/lab2_cpp.dir/depend

