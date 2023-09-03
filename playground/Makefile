PROGRAM = playground

build: $(PROGRAM)

$(PROGRAM): $(PROGRAM).o
	ld -m elf_i386 $< -o $@

%.o: %.asm
	nasm -f elf $<

.PHONY: new
new:
	cp ./newplayground.asm ./$(PROGRAM).asm
	sed -i "s/Playground Program Template/$(PROGRAM)/" ./$(PROGRAM).asm

.PHONY: run
run:
	./$(PROGRAM)

.PHONY: clean
clean:
	$(RM) $(PROGRAM) $(PROGRAM).*
