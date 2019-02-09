CPP_FILES := shortestPath.cpp

OBJ_FILES := $(addprefix bin/obj/,$(notdir $(CPP_FILES:.cpp=.o)))
DEBUG_OBJ_FILES := $(addprefix bin/debug/,$(notdir $(CPP_FILES:.cpp=.o)))

LD_FLAGS := -L/usr/local/cuda/lib64/
LD_FLAGS += -lOpenCL
CC_FLAGS += -I/usr/local/cuda/include/ --std=c++11

#---------------------Normal Build---------------------#

main.out: $(OBJ_FILES)
	g++ -o $@ $(OBJ_FILES) $(LD_FLAGS) $(BUILD_NUMBER_LD_FLAGS)

bin/obj/%.o: shortestPath.cpp
	g++ -c -o $@ $< $(CC_FLAGS) $(LD_FLAGS) -w


#----------------------Debug Mode----------------------#

debug: $(DEBUG_OBJ_FILES)
	g++ -o main.out $(DEBUG_OBJ_FILES) $(LD_FLAGS)

bin/debug/%.o: shortestPath.cpp
	g++ -c -o $@ $< $(LD_FLAGS) $(CC_FLAGS) -w -DDEBUG

#-------------------------Clean------------------------#
