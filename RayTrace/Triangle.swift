//
//  Triangle.swift
//  RayTrace
//
//  Created by Бабинцев Павел Валерьевич on 07.07.2022.
//

import Foundation
import AppKit

struct Triangle
{
	let p1,p2,p3: Vector
	let radius: Double
	let color: NSColor
}


extension Triangle: IIntersectObject
{
	func intersect(ray: Ray) -> Vector? {
		return nil
	}
	
	func normal(point: Vector) -> Vector {
		return .one
	}
	
}

private extension Triangle
{
	func plane() -> (A: Double, B: Double, C: Double, D: Double )
	{
		let A = (p2.y - p1.y) * (p3.z - p1.z) - (p2.z - p1.z) * (p3.y - p1.y)
		
		let B = -( (p2.x - p1.x) * (p3.z - p1.z) - (p2.z - p1.z) * (p3.y - p1.y) )
		
		let C = (p2.y - p1.y) * (p3.z - p1.z) - (p2.z - p1.z) * (p3.y - p1.y)
		
		return (A: A, B: B, C: C, 0)
	}
}
