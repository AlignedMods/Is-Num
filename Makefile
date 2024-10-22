CC=gcc
AR=ar

BUILD_DIR=build
SRC_DIR=src

LIBTYPE?=STATIC

LIB?=$(BUILD_DIR)/libisnum.a

SOURCES=$(wildcard $(SRC_DIR)/*.c)
OBJECTS=$(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(SOURCES))

ifeq ($(LIBTYPE), STATIC)
    LIB=$(BUILD_DIR)/libisnum.a
else
    LIB=$(BUILD_DIR)/libisnum.so
endif

.PHONY: all clean always test

all: always $(LIB)

$(LIB): $(OBJECTS)
ifeq ($(LIBTYPE), STATIC)
	$(AR) rcs $< $<
else
	$(CC) -shared $^ -o $@
endif

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) -c $< -o $@

clean:
	rm -rf $(BUILD_DIR)

always:
	mkdir -p $(BUILD_DIR)
