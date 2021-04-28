//
//  UIColorExtension.swift
//  Pokedex
//
//  Created by Andrea Mannucci  on 26/04/2021.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        let redPart: CGFloat = CGFloat(red) / 255
        let greenPart: CGFloat = CGFloat(green) / 255
        let bluePart: CGFloat = CGFloat(blue) / 255
        self.init(red: redPart, green: greenPart, blue: bluePart, alpha: alpha)
    }
    
    convenience init(netHex:Int, alpha: CGFloat) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff, alpha: alpha)
    }
}

