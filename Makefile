
TARGETS = head_block_mount.stl

all: $(TARGETS)

.SECONDARY: $(patsubst %.stl, %.scad, "${TARGETS}")

include $(wildcard *.deps)

%.stl: %.scad
	openscad -m make -o $@ -d $@.deps $<
