
TARGETS = head_block_mount.stl head_block_shaft.stl head_block_support.stl head_internal.stl head_vertical_axle.stl

all: $(TARGETS)

.SECONDARY: $(patsubst %.stl, %.scad, "${TARGETS}")

include $(wildcard *.deps)

%.stl: %.scad
	openscad -m make -o $@ -d $@.deps $<
