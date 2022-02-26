const std = @import("std");

pub fn build(builder: *std.build.Builder) !void {
    const lib = builder.addSharedLibrary("zig_example_ext", "zig_example_ext.zig", builder.version(0, 0, 1));
    try lib.linkSystemLibraryPkgConfigOnly("ruby-3.1");
    lib.install();
    builder.default_step.dependOn(&lib.step);
}
