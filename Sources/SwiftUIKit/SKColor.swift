//
//  File.swift
//  
//
//  Created by Shota Shimazu on 2022/04/27.
//

import UIKit


public struct SKColor {
    var inColor: Any

    public var uiColor: UIColor {
        get {
            if let swiftUIColor = inColor as? Color {
                return colorToUIColor(swiftUIColor)
            }
            
            if let uiColor = inColor as? UIColor {
                return uiColor
            }

            return inColor as! UIColor
        }

        set {
            inColor = newValue
        }
    }

    public var color: Color {
        get {
            if let uiColor = inColor as? UIColor {
                return uiColorToColor(uiColor)
            }
            
            if let swiftUIColor = inColor as? Color {
                return swiftUIColor
            }

            return inColor as! Color
        }

        set {
            inColor = newValue
        }
    }


    public init<T>(_ color: T) {
        self.inColor = color
    }

    private func uiColorToColor(_ color: UIColor) -> Color {
        return Color(color)
    }

    private func colorToUIColor(_ color: Color) -> UIColor {

        if #available(iOS 14.0, *) {
            return UIColor(color)
        }

        let scanner = Scanner(string: color.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0

        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            r = CGFloat((hexNumber & 0xFF000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00FF0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000FF00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000FF) / 255
        }
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
