//
//  Vector.swift
//  RayTrace
//
//  Created by Бабинцев Павел Валерьевич on 07.07.2022.
//

import Foundation

struct Vector
{
	var x,y,z: Double
	
	static let zero = Vector(x: 0.0, y: 0.0, z: 0.0)
	static let one = Vector(x: 1.0, y: 1.0, z: 1.0)
	static let two = Vector(x: 2.0, y: 2.0, z: 2.0)
}


func +(left: Vector, right: Vector) -> Vector {
	return Vector(x: left.x + right.x,
				  y: left.y + right.y,
				  z: left.z + right.z)
}

func -(left: Vector, right: Vector) -> Vector {
	return Vector(x: left.x - right.x,
				  y: left.y - right.y,
				  z: left.z - right.z)
}

func *(left: Vector, right: Vector) -> Double {
	return
		left.x * right.x +
		left.y * right.y +
		left.z * right.z
}

func mod(_ vector: Vector) -> Double
{
	return sqrt(vector * vector)
}

func cos(left: Vector, right: Vector) -> Double
{
	return (left * right) / (mod(left) * mod(right))
}
