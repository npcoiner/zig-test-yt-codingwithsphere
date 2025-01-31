const std = @import("std");
const rl = @import("raylib");

pub fn main() !void {
    const windowWidth: i32 = 1280;
    const windowHeight: i32 = 720;
    const targetFPS: i32 = 30;
    rl.initWindow(windowWidth, windowHeight, "zig raylib example");
    defer rl.closeWindow();

    rl.setTargetFPS(targetFPS);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.drawText("FUCK YOU!!", 100, 100, 20, rl.Color.light_gray);
        rl.clearBackground(rl.Color.sky_blue);
    }
}
