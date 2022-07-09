//
//  Image.swift
//  RayTrace
//
//  Created by Бабинцев Павел Валерьевич on 06.07.2022.
//

import AppKit

public struct RGBAColor
{
	var a,r,g,b: UInt8
	
	static let white = RGBAColor(a: 255, r: 255, g: 255, b: 255)
}

extension NSImage {
	convenience init?(pixels: [NSColor], width: Int, height: Int) {
		guard width > 0 && height > 0, pixels.count == width * height else { return nil }
		var data:[RGBAColor] = pixels.map({ rgbColor(from:$0) })
		guard let providerRef = CGDataProvider(data: Data(bytes: &data, count: data.count * MemoryLayout<RGBAColor>.size) as CFData)
			else { return nil }
		guard let cgim = CGImage(
			width: width,
			height: height,
			bitsPerComponent: 8,
			bitsPerPixel: 32,
			bytesPerRow: width * MemoryLayout<RGBAColor>.size,
			space: CGColorSpaceCreateDeviceRGB(),
			bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue),
			provider: providerRef,
			decode: nil,
			shouldInterpolate: true,
			intent: .defaultIntent)
		else { return nil }
		self.init(cgImage: cgim, size: NSSize(width: width, height: height))
	}
	
	var pngData: Data? {
		guard let tiffRepresentation = tiffRepresentation, let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else { return nil }
		return bitmapImage.representation(using: .png, properties: [:])
	}
	
	@discardableResult
	func pngWriteToDestop(filename: String, options: Data.WritingOptions = .atomic)  -> Bool {
		let fileURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!.appendingPathComponent(filename)
		return self.pngWrite(to: fileURL)
	}
	func pngWrite(to url: URL, options: Data.WritingOptions = .atomic) -> Bool {
		do {
			try pngData?.write(to: url, options: options)
			return true
		} catch {
			print(error)
			return false
		}
	}
}
