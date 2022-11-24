const std = @import("std");

pub fn build(builder: *std.build.Builder) !void {
    const stdout = try builder.exec(&.{ "brew", "--prefix", "ruby@3.1" });
    const ruby_prefix = std.mem.trimRight(u8, stdout, "\r\n");
    const ruby_lib_path = builder.fmt("{s}/lib", .{ruby_prefix});
    const ruby_config_path = builder.fmt("{s}/lib/pkgconfig", .{ruby_prefix});

    try builder.env_map.put("PKG_CONFIG_PATH", ruby_config_path);

    const lib = builder.addSharedLibrary("zig_example_ext", "zig_example_ext.zig", builder.version(0, 0, 1));
    lib.linkSystemLibraryPkgConfigOnly("ruby-3.1");
    lib.addLibraryPath(ruby_lib_path);
    lib.install();
    builder.default_step.dependOn(&lib.step);
}
