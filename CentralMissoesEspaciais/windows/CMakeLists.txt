cmake_minimum_required(VERSION 3.14)
project(runner LANGUAGES CXX)

set(BINARY_NAME "central_missoes_espaciais")
add_executable(${BINARY_NAME} runner/main.cpp)
