# Learn Assembly

Most of the code examples in this repository are based on the excellent tutorials from [asmtutor](https://asmtutor.com/). I am using these lessons as part of my journey to learn Assembly language. My process has been to work through the examples myself, adding my own comments and debugging where needed, in order to deeply understand the concepts.

Going forward, I plan to build on this foundation from **asmtutor** and explore Assembly more broadly using additional resources and books. As I continue learning, I will update this repository with new examples and insights as a personal reference.

## GNU Debugger

To compile Assembly code with debug information, add the `-g` option when running the NASM assembler:

```bash
$ nasm -f elf -g hello_world.asm
```

Without the `-g` flag, you can still debug the output program but there will be no linked source code. The `list` command in the debugger will show nothing.

However, since the original source is x86 Assembly, debugging without `-g` is not much different. The instructions are visible in either case.
