//
//  UIView+ext.swift
//  NewDatingApp
//
//  Created by Valik Kuchinsky on 2/17/18.
//  Copyright © 2018 Dating App. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(className, owner: nil, options: nil)![0] as! T
    }
    
    func addShadow(offset: CGSize = CGSize(width: 0, height: 0), color: UIColor = UIColor.black, radius: CGFloat = 5.0, opacity: Float = 0.1) {
        let layer = self.layer
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        let backgroundCGColor = self.backgroundColor?.cgColor
        self.backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: alpha)
    }
}

extension UIButton {
    
    func setBackgroundColor(_ color: UIColor, for state: UIControlState) {
        
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        setBackgroundImage(colorImage, for: state)
    }
    
    override open var isHighlighted: Bool {
        didSet { if isHighlighted { isHighlighted = false } }
    }
}

extension UILabel {
    func textDropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
    }
}
