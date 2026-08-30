//
//  UIImage ext.swift
//  wCards
//
//  Created by Fedor Komov on 30.08.2026.
//

import SwiftUI

extension UIImage {
    func rotated(by degrees: CGFloat) -> UIImage? {
        let radians = degrees * .pi / 180
        var newSize = CGRect(origin: .zero, size: self.size)
            .applying(CGAffineTransform(rotationAngle: radians)).size
        
        // Trim fractional values to prevent floating-point artifacts
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.translateBy(x: newSize.width / 2, y: newSize.height / 2)
        context.rotate(by: radians)
        
        self.draw(in: CGRect(x: -self.size.width / 2, 
                             y: -self.size.height / 2, 
                             width: self.size.width, 
                             height: self.size.height))
        
        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return rotatedImage?.withRenderingMode(self.renderingMode)
    }
}



/// Example
//Button(action: { 
//  print("Rotated action clicked") 
//}) {
//  Label {
//    Text("Cut from the list")
//  } icon: {
//    if let rotatedImg = UIImage(systemName: "tray.and.arrow.up")?.rotated(by: 90) {
//      Image(uiImage: rotatedImg)
//    }
//  }
//}
                  
