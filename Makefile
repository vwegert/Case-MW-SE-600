#
# The following variables contain some OS-specific settings with default values set for a Mac OS X installation.
# Adjust these parameters to match your installation.
#

# The make executable.
MAKE = /usr/bin/make

# The full path to the OpenSCAD executable.
OPENSCAD = /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD

#
# phony target definitions (targets that are no files)
#
.PHONY: all clean 

#
# default targets all and clean
#
all: CoverPrimary.stl   \
	 LidPrimary.stl     \
	 CoverSecondary.stl \
	 LidSecondary.stl

clean:
	$(RM) *.deps
	$(RM) *.stl

#
# file-type specific build rules
#
%.stl: %.scad 
	$(OPENSCAD) -m $(MAKE) -o $@ -d $@.deps $<

#
# Include the dependency files provided by OpenSCAD. 
#
include $(wildcard *.deps)

