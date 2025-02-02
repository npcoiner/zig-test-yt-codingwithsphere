const std = @import("std");
const rl = @import("raylib");

pub fn main() !void {
    const windowWidth: i32 = 1280;
    const windowHeight: i32 = 720;
    const targetFPS: i32 = 30;

    //Initialize the window with deferred close.
    rl.initWindow(windowWidth, windowHeight, "zig raylib example");
    defer rl.closeWindow();

    rl.setTargetFPS(targetFPS);

    var camera = rl.Camera3D{
        .position = rl.Vector3{ .x = 10.0, .y = 10.0, .z = 10.0 },
        .target = rl.Vector3{ .x = 0.0, .y = 0.0, .z = 0.0 },
        .up = rl.Vector3{ .x = 0.0, .y = 1.0, .z = 0.0 },
        .fovy = 45.0,
        .projection = rl.CameraProjection.perspective,
    };

    rl.disableCursor(); //Don't do this, causes errors
    rl.toggleFullscreen();
    rl.hideCursor();

    while (!rl.windowShouldClose()) {
        if (rl.isKeyDown(rl.KeyboardKey.space)) {
            camera.position.y += 0.1;
        }
        if (rl.isKeyDown(rl.KeyboardKey.left_control)) {
            camera.position.y -= 0.1;
        }

        rl.updateCamera(&camera, rl.CameraMode.first_person);
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.ray_white);

        rl.beginMode3D(camera);
        defer rl.endMode3D();

        //Test cube
        //rl.drawGrid(10, 1.0);
        rl.drawCube(rl.Vector3{ .x = 0, .y = 0, .z = 0 }, 2, 2, 2, rl.Color.red);
        //rl.drawCubeWires(rl.Vector3{ .x = 0, .y = 0, .z = 0 }, 2, 2, 2, rl.Color.maroon);
    }
}
