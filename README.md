# Eagle 🦅

_🦅A tool for debugging the view hierarchy_

## Description

Eagle is basically an extension to the `UIViewController` class that presents a list with the view hierarchy 
(an image and name of each view) upon a shake gesture or upon calling the method `🦅()` in lldb.

## Instalation

You can simply copy and paste the `Eagle.swift` file to you project and _it just works_.

⚠️ Don't forget to disable it when shipping the application!!! Your users won't wanna see the view hierarchy
anywhere except in the beautiful user interface you've created for your app.

## Usage

Shake the device (or simulate it with `cmd + ctrl + z` in the simulator) and a view controller will appear with
a list of the subviews of the top view controller's `view`.

If you prefer, you can also call `e 🦅()` in lldb if your breakpoint is inside a `UIViewController` subclass.
