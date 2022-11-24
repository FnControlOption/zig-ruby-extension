const std = @import("std");
const c = @cImport(@cInclude("ruby.h"));

fn salute(greeter: c.VALUE, name: c.VALUE) callconv(.C) c.VALUE {
    _ = greeter;

    var rb_str = c.rb_str_to_str(name);
    const c_str  = c.rb_string_value_cstr(&rb_str);

    std.debug.print("Hello, {s}!!!\n", .{c_str});

    return name;
}

pub export fn Init_zig_example_ext() void {
    const greeter = c.rb_define_class("Greeter", c.rb_cObject);
    c.rb_define_method(greeter, "salute", @ptrCast(*const fn (...) callconv(.C) c.VALUE, &salute), 1);
}