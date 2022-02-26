RUBY_ROOT = ${HOME}/.rbenv/versions/3.1.0
export PKG_CONFIG_PATH = $(RUBY_ROOT)/lib/pkgconfig

TARGET = zig_example_ext.bundle

$(TARGET): zig_example_ext.zig
	zig build
	cp -L zig-out/lib/libzig_example_ext.dylib $@

.PHONY: test
test: $(TARGET)
	ruby test.rb

.PHONY: clean
clean:
	rm -f $(TARGET)
	rm -rf zig-cache zig-out
