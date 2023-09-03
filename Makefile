CODEDIRS = code/* playground

.PHONY: build clean
build clean:
	for dir in $(CODEDIRS); do \
		$(MAKE) -C $$dir -f Makefile $@; \
	done
