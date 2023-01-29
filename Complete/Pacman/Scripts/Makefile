# Paths
OBJDIR := ../build
SRC := main.asm
PRG1 := $(OBJDIR)/main.prg
ASM := java -cp "$(HOME)/Programs/KickAssembler/*" kickass.KickAssembler

# Commands
MKPRG1 = $(ASM) -odir $(OBJDIR) $(SRC)
RM := rm -rf
MKDIR := mkdir -p

# Targets
.PHONY: all clean

all: $(PRG1)

$(OBJDIR):
	$(MKDIR) $(OBJDIR)

clean:
	$(RM) $(OBJDIR)

# Rules
$(PRG1): $(SRC)
	$(MKPRG1)
