# cmake_minimum_required(VERSION <specify CMake version here>)
project(lab2_cpp)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -Wall")
add_executable(lab2_cpp main.cpp)
