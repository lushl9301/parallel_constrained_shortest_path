CPP_FILES := shortestPath.cpp

OBJ_FILES := $(addprefix bin/obj/,$(notdir $(CPP_FILES:.cpp=.o)))
DEBUG_OBJ_FILES := $(addprefix bin/debug/,$(notdir $(CPP_FILES:.cpp=.o)))
AOCL_OBJ_FILES := $(addprefix bin/aocl_common/,$(notdir $(AOCL_CPP_FILES:.cpp=.o)))

LD_FLAGS := -L/usr/local/cuda/lib64/
LD_FLAGS += -lOpenCL
CC_FLAGS += -I/usr/local/cuda/include/ --std=c++11

#---------------------Normal Build---------------------#

main.out: $(OBJ_FILES)
	g++ -o $@ $(OBJ_FILES) $(LD_FLAGS) $(BUILD_NUMBER_LD_FLAGS)


bin/obj/%.o: shortestPath.cpp
	g++ -c -o $@ $< $(CC_FLAGS) $(LD_FLAGS) -w

bin/obj/%.o: percolation_graph_io.cpp
	g++ -c -o $@ $< $(CC_FLAGS) $(LD_FLAGS) -w

#bin/obj/%.o: percolation_parallel.cpp
#	g++ -c -o $@ $< $(CC_FLAGS) $(LD_FLAGS) -w

#----------------------Debug Mode----------------------#

debug: $(DEBUG_OBJ_FILES) aocl_common.o
	g++ -o main.out $(DEBUG_OBJ_FILES) bin/aocl_common/*.o $(LD_FLAGS)

bin/debug/%.o: shortestPath.cpp
	g++ -c -o $@ $< $(LD_FLAGS) $(CC_FLAGS) -w -DDEBUG

bin/debug/%.o: percolation_graph_io.cpp
	g++ -c -o $@ $< $(CC_FLAGS) $(LD_FLAGS) -w -DDEBUG

bin/debug/%.o: percolation_parallel.cpp
	g++ -c -o $@ $< $(CC_FLAGS) $(LD_FLAGS) -w -DDEBUG

clean_debug: clean debug

#-------------------------Clean------------------------#
