//
//  Extensions.swift
//  Photos Task
//
//  Created by Walid Ahmed on 04/04/2023.
//

import Foundation
import UIKit

extension UIImage {
    func getDominantColor() -> UIColor? {
        // Resize image to reduce computational complexity
        let size = CGSize(width: 50, height: 50)
        guard let resizedImage = UIGraphicsImageRenderer(size: size).image(actions: { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }).cgImage else {
            return nil
        }
        
        // Create CIImage from CGImage
        let ciImage = CIImage(cgImage: resizedImage)
        
        // Apply CIAreaMaximum filter to get the most dominant color
        let extentVector = CIVector(x: 0, y: 0, z: size.width, w: size.height)
        guard let maxFilter = CIFilter(name: "CIAreaMaximum", parameters: [
            kCIInputImageKey: ciImage,
            kCIInputExtentKey: extentVector
        ]), let outputImage = maxFilter.outputImage else {
            return nil
        }
        
        // Convert CIImage to CGImage
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return nil
        }
        
        // Get pixel data from CGImage
        let data = cgImage.dataProvider?.data as Data?
        let pixelData = data?.withUnsafeBytes { [UInt8](UnsafeBufferPointer(start: $0.baseAddress?.assumingMemoryBound(to: UInt8.self), count: data?.count ?? 0)) } ?? []
        
        // Get RGB values of the dominant color
        let red = pixelData[0]
        let green = pixelData[1]
        let blue = pixelData[2]
        
        // Create UIColor from RGB values
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
