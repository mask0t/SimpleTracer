//
//  main.swift
//  RayTrace
//
//  Created by Бабинцев Павел Валерьевич on 06.07.2022.
//

import Foundation
import AppKit

let greenSphere = Sphere(center: .init(x: 100, y: 0, z: 0), radius: 20.0, color: .green)
let redSphere = Sphere(center: .init(x: 80, y: 20, z: 0), radius: 20.0, color: .red)



let viewport = ViewPort(center: .zero)
let lighter = Lighter(center: .init(x: 0, y: 0, z: 100))
let pixels = trace(viewPort: .init(center: .zero), objects: [greenSphere, redSphere], lighter: lighter)
let image = NSImage(pixels: pixels, width: viewport.width, height: viewport.height)


image?.pngWriteToDestop(filename: "my.png")


