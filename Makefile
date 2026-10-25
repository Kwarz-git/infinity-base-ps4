TARGET   := infinity_base_en.prx
LIBS     := -lSceLibcInternal -lkernel -lSceSysmodule
TOOLCHAIN := $(OO_PS4_TOOLCHAIN)
CFLAGS   := --target=x86_64-pc-freebsd12-elf -fPIC -funwind-tables -c -isysroot $(TOOLCHAIN) -isystem $(TOOLCHAIN)/include -isystem $(TOOLCHAIN)/include/orbis/_types
LDFLAGS  := -m elf_x86_64 -pie --export-dynamic --script $(TOOLCHAIN)/link.x -e _init --eh-frame-hdr -L$(TOOLCHAIN)/lib $(LIBS)

all:
	@mkdir -p build
	clang $(CFLAGS) -o build/main.o source/main.c
	clang -target x86_64-pc-linux-gnu -ffreestanding -nostdlib -fno-builtin -fPIC -isysroot $(TOOLCHAIN) -isystem $(TOOLCHAIN)/include -c $(CURDIR)/../GoldHEN_Plugins_SDK/crt/crtprx.c -o build/crtprx.o
	ld.lld build/main.o build/crtprx.o -o build/plugin.elf $(LDFLAGS)
	$(TOOLCHAIN)/bin/linux/create-fself -in=build/plugin.elf -out=build/plugin.oelf --lib=$(TARGET) --paid 0x3800000000000011

clean:
	rm -rf build $(TARGET)
