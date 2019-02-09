cmake_minimum_required(VERSION 3.12)
project(parallel_constrained_shortest_path)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)
include_directories(/usr/local/cuda/include/)
SET(CMAKE_CXX_FLAGS "-g -L/usr/local/cuda/lib64/ -lOpenCL")
add_executable(parallel_csp
               shortestPath.cpp)
