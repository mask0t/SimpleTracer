//
//  Sphere.swift
//  RayTrace
//
//  Created by Бабинцев Павел Валерьевич on 06.07.2022.
//

import Foundation
import AppKit

struct Sphere
{
	let center: Vector
	let radius: Double
	let color: NSColor
}

extension Sphere: IIntersectObject
{
	func normal(point: Vector) -> Vector {
		return point - center
	}
	
	func intersect(ray: Ray) -> Vector? {
		let u = ray.vec
		let p = ray.start
		let c = self.center
		let R = self.radius
		
		let A = u.x * u.x +
				u.y * u.y +
				u.z * u.z
		
		let B = 2.0 * ( u.x * ( p.x - c.x) +
						u.y * ( p.y - c.y) +
						u.z * ( p.z - c.z) )
		
		let C = (p.x - c.x) * (p.x - c.x) +
				(p.y - c.y) * (p.y - c.y) +
				(p.z - c.z) * (p.z - c.z) - R*R
		
		let D = B*B - 4.0 * A * C
		
		if D < 0.0
		{
			return nil
		}
		let t: Double
		if D.isZero
		{
			 t = -B / (2.0 * A)
		}
		else
		{
			let t1 = (-B + sqrt(D)) / (2.0 * A)
			let t2 = (-B - sqrt(D)) / (2.0 * A)
			
			t = t1 < t2 ? t1 : t2
		}
		return Vector(x: p.x + t * u.x,
					  y: p.y + t * u.y,
					  z: p.z + t * u.z)
	}
}
