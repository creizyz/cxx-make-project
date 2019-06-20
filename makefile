# project options
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
PROJECT_NAME     := xxxxx
PROJECT_VERSION  := 0.1

PROJECT_INCLUDE  :=
PROJECT_LIB      := 
PROJECT_LIB_PATH := 

INCLUDE_DIR      := include
SOURCE_DIR       := source

# build tools
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
CXX := g++
LD  := g++

# recursive wildcard definition
rwildcard = $(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

# program build configuration
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
BUILDDIR  := build
OBJDIR    := $(BUILDDIR)/obj
OUTDIR    := $(BUILDDIR)/bin

EXEC      := $(OUTDIR)/$(PROJECT_NAME)-$(PROJECT_VERSION)
FLAGS     := -Wall
CXXFLAGS  := $(FLAGS)
CXXFLAGS  += -Wextra -Wwrite-strings -Wno-parentheses
CXXFLAGS  += -Wpedantic -Warray-bounds -Weffc++
LDFLAGS   := $(FLAGS)

INC       := $(PROJECT_INCLUDE:%=-I%) -I$(INCLUDE_DIR)
LIB       := $(PROJECT_LIB_PATH:%=-L%) $(PROJECT_LIB:%=-l%)
SRC       := $(call rwildcard,$(SOURCE_DIR)/,*.cpp)
OBJ       := $(SRC:$(SOURCE_DIR)/%.cpp=$(OBJDIR)/%.o)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - #

.PHONY: all clean mrproper

# Commands
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - #  
all: $(EXEC)

clean:
	@rm -Rf $(OBJDIR)

mrproper: clean
	@rm -Rf $(OUTDIR)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - #  

# Make rules
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
$(EXEC): $(OBJ)
	@mkdir -p $(dir $@)
	$(LD) $(LDFLAGS) $(LIB) -o $@ $^

$(OBJDIR)/%.o: $(SOURCE_DIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(INC) -o $@ -c $<

$(OBJDIR)/%.d : $(SOURCE_DIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(INC) $(CXXFLAGS) -MM -MF $@ -MT $(@:%.d=%.o) $<
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - #

MAKEFILE_TARGETS_WITHOUT_INCLUDE := clean mrproper
