//
//  Models.swift
//  RayTrace
//
//  Created by Бабинцев Павел Валерьевич on 06.07.2022.
//

import Foundation
import AppKit


struct Ray
{
	let start: Vector
	let vec: Vector
}

protocol IIntersectObject
{
	var color: NSColor { get }

	func intersect(ray: Ray) -> Vector?
	func normal(point: Vector) -> Vector
}


struct ViewPort
{
	let center: Vector
	let width = 800
	let height = 600
}

struct Lighter
{
	let center: Vector
}
