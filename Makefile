# Compiler
CC := gcc

# Compiler flags
CFLAGS := -Wall -Wextra -fPIC

# Directories
SRC_DIR := src
INCLUDE_DIR := include
BIN_DIR := bin
OBJ_DIR := $(BIN_DIR)/objs

# libIO library  NOTE: tilde resolution does not work here ~/ 24.04 Ubuntu Linux
LIB_IO := /home/alex/Desktop/'Assembly Code'/libIO/bin
LIB_IO_INCLUDE := /home/alex/Desktop/'Assembly Code'/libIO/include

# Source files
SRCS := $(wildcard $(SRC_DIR)/*.s)

# Object files
OBJS := $(patsubst $(SRC_DIR)/%.s,$(OBJ_DIR)/%.o,$(SRCS))

# Library name
LIBRARY := $(BIN_DIR)/libStringFuncs.so

# Executable name and path
EXECUTABLE := $(BIN_DIR)/driver

# Libraries to link against
EXEC_LIBS :=  -lStringFuncs -lIOLibrary

EXEC_LIBS_PATHS := -L$(BIN_DIR) -L$(LIB_IO) 

INCLUDES := -I${INCLUDE_DIR} -I${LIB_IO_INCLUDE}

# Default target
# Build shared library and delete temp objs folder
all: $(LIBRARY) 
	@echo "Build completed"
	@$(MAKE) clean

# Rule to create temp objs folder if it doesn't exist
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

# Rule to assemble assembly files to object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to link object files into shared library
$(LIBRARY): $(OBJS) | $(OBJ_DIR)
	$(CC) $(CFLAGS) -shared $^ -o $@

# Delete temp objs folder
clean:
	rm -rf $(OBJ_DIR)
	@echo "Cleaned up"

# Run target (build library if necessary, compile driver.c, and run executable)
run: $(EXECUTABLE)
	@$(MAKE) clean
	@echo "Running $(EXECUTABLE)"
	LD_LIBRARY_PATH=$(BIN_DIR):$(LIB_IO) ./$(EXECUTABLE)

# Compile driver.c, create SringFuncs library, and link with shared library
$(EXECUTABLE): $(LIBRARY) driver.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) ${EXEC_LIBS_PATHS} ${INCLUDES}  driver.c -o $(EXECUTABLE) $(EXEC_LIBS)

.PHONY: all clean run

