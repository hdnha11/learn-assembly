PROGRAM = calculator_multiplication

build: $(PROGRAM)

$(PROGRAM): $(PROGRAM).o
	ld -m elf_i386 $< -o $@

%.o: %.asm
	nasm -f elf $<

.PHONY: run
run:
	./$(PROGRAM)

.PHONY: clean
clean:
	$(RM) $(PROGRAM) $(PROGRAM).o
