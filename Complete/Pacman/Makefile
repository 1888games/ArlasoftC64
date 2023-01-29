# Paths
OBJDIR := build
SRCDIR := Scripts
PRG1 := $(OBJDIR)/main.prg
PRG2 := $(OBJDIR)/pacman.prg
D64 := $(OBJDIR)/pacman_FH.d64
PAK := exomizer sfx sys -t 64

# Commands
MKPRG2 = $(PAK) -o $(PRG2) $(PRG1)
RM := rm -rf
MKDIR := mkdir -p
MKD64 = c1541 -format 'pacman fh',pm d64 $@ $(foreach p,$(PRG2),-write $(p) $(subst .prg,,$(subst build/,,$(p))))

# Targets
.PHONY: all clean

all: $(D64)

$(OBJDIR):
	$(MKDIR) $(OBJDIR)

clean:
	$(RM) $(OBJDIR)

# Rules
$(PRG1):
	$(MAKE) -C $(SRCDIR)

$(PRG2): $(PRG1)
	$(MKPRG2)

$(D64): $(PRG2)
	$(MKD64)
