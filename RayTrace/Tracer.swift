//
//  Tracer.swift
//  RayTrace
//
//  Created by Бабинцев Павел Валерьевич on 06.07.2022.
//

import Foundation
import AppKit

func trace(viewPort: ViewPort, objects: [IIntersectObject], lighter: Lighter) -> [NSColor]
{
	var pixels = [NSColor](repeating: .white, count: viewPort.width * viewPort.height)
	let dx: Double = 1.33 / Double(viewPort.width)
	let dy: Double = 1.0 / Double(viewPort.height)
	
	let startx = Double(viewPort.width) / 2.0 * dx
	let starty = Double(viewPort.height) / 2.0 * dy

	for j in 0..<viewPort.height {
		for i in 0..<viewPort.width
		{
			let y = -startx + Double(i) * dx
			let z = starty - Double(j) * dy
			let ray = Ray(start: .zero, vec: .init(x: 1, y: y, z: z))
			let (object, point) = intersectObject(objects: objects, ray: ray)
			let color = color(object: object, point: point, lighter: lighter)
			
			pixels[j*viewPort.width + i] = color
		}
		
	}
	
	return pixels
}

func color(object: IIntersectObject?, point: Vector?, lighter: Lighter) -> NSColor
{
	guard let obj = object, let p = point else { return .gray }
	
	let norm = obj.normal(point: p)
	
	let cos = cos(left: norm, right: lighter.center - p)
	return cos > 0 ? obj.color.withLuminosity(cos) : .black
}


func intersectObject(objects: [IIntersectObject], ray: Ray) -> (IIntersectObject?, Vector?)
{
	var cur: (IIntersectObject, Double, Vector)? = nil
	for obj in objects
	{
		if let point = obj.intersect(ray: ray)
		{
			let depth = mod(ray.start - point)
			if let curv = cur {
				if curv.1 > depth {
					cur = (obj, depth, point)
				}
			}
			else
			{
				cur = (obj, depth, point)
			}
		}
	}
	
	return (cur?.0, cur?.2)
}
