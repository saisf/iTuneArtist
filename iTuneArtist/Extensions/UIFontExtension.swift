//
//  UIFontExtension.swift
//  iTuneArtist
//
//  Created by Sai Leung on 2/20/21.
//

import Foundation
import UIKit

extension UIFont {
    /**
     This function returns a SF Rounded UIFont
     */
    class func rounded(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
            let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
            let font: UIFont
            
            if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
                font = UIFont(descriptor: descriptor, size: size)
            } else {
                font = systemFont
            }
            return font
        }
}
