const std = @import("std");
const rl = @import("raylib");

pub fn main() !void {
    const windowWidth: i32 = 1920;
    const windowHeight: i32 = 1080;
    const targetFPS: i32 = 30;
    const backgroundColor: rl.Color = rl.Color.ray_white;
    const sensitivity: f32 = 0.1;

    //Initialize the window with deferred close.
    rl.initWindow(windowWidth, windowHeight, "zig raylib example");
    defer rl.closeWindow();

    rl.setTargetFPS(targetFPS);

    rl.disableCursor();
    rl.toggleFullscreen();
    var camera = createCamera();

    while (!rl.windowShouldClose()) {
        handleKeyPress(&camera);

        rl.updateCameraPro(&camera, getMovementMatrix(), getRotationMatrix(sensitivity), 0);

        //rl.updateCamera(&camera, rl.CameraMode.first_person);
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(backgroundColor);

        rl.beginMode3D(camera);
        defer rl.endMode3D();

        //Test cubes
        rl.drawGrid(100, 1.0);
        rl.drawCube(rl.Vector3{ .x = 10, .y = 0, .z = 0 }, 2, 2, 2, rl.Color.red);
        rl.drawCube(rl.Vector3{ .x = 0, .y = 10, .z = 0 }, 2, 2, 2, rl.Color.green);
        rl.drawCube(rl.Vector3{ .x = 0, .y = 0, .z = 10 }, 2, 2, 2, rl.Color.blue);
    }
}

fn createCamera() rl.Camera3D {
    return rl.Camera3D{
        .position = rl.Vector3{ .x = 0.0, .y = 2.0, .z = 0.0 },
        .target = rl.Vector3{ .x = 10.0, .y = 0.0, .z = 10.0 },
        .up = rl.Vector3{ .x = 0.0, .y = 1.0, .z = 0.0 },
        .fovy = 60.0,
        .projection = rl.CameraProjection.perspective,
    };
}

fn getRotationMatrix(sensitivity: f32) rl.Vector3 {
    const mouseDelta = rl.getMouseDelta();
    //init rotation matrix
    var rotation = rl.Vector3{ .x = 0, .y = 0, .z = 0 };
    //phi = y
    rotation.x += mouseDelta.x * sensitivity;
    rotation.y += mouseDelta.y * sensitivity;

    return rotation;
}

fn getMovementMatrix() rl.Vector3 {
    var movementMarix = rl.Vector3{ .x = 0, .y = 0, .z = 0 };
    if (rl.isKeyDown(rl.KeyboardKey.w)) {
        movementMarix.x += 0.1;
    }
    if (rl.isKeyDown(rl.KeyboardKey.a)) {
        movementMarix.y -= 0.1;
    }
    if (rl.isKeyDown(rl.KeyboardKey.s)) {
        movementMarix.x -= 0.1;
    }
    if (rl.isKeyDown(rl.KeyboardKey.d)) {
        movementMarix.y += 0.1;
    }
    return movementMarix;
}

fn handleKeyPress(camera: *rl.Camera3D) void {
    if (rl.isKeyDown(rl.KeyboardKey.space)) {
        camera.position.y += 0.1;
    }
    if (rl.isKeyDown(rl.KeyboardKey.left_control)) {
        camera.position.y -= 0.1;
    }
}
