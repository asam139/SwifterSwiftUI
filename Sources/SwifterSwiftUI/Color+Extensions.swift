//
//  Color+Extensions.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 25/04/2020.
//

import SwiftUI

extension Color {

    /// Create a color from hex string
    ///
    ///    let myGradient = Color(hex: "FFFFFF")
    ///
    /// - Parameters:
    ///   - hex: hex color string
    /// - Returns: New color from the hex value
    init?(hex: String) {
        let hexColor: String?
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            hexColor = String(hex[start...])
        } else {
            hexColor = hex
        }

        guard let validString = hexColor else {
            return nil
        }

        let count = validString.count
        guard count == 6 || count == 8 else {
            return nil
        }

        let scanner = Scanner(string: validString)
        var hexNumber: UInt64 = 0
        guard scanner.scanHexInt64(&hexNumber) else {
            return nil
        }

        let r, g, b, a: Double
        if count == 6 { //rgb
            r = Double((hexNumber & 0x00ff0000) >> 16)
            g = Double((hexNumber & 0x0000ff00) >> 8)
            b = Double(hexNumber & 0x000000ff)
            a = 255

        } else { //rgba
            r = Double((hexNumber & 0xff000000) >> 24)
            g = Double((hexNumber & 0x00ff0000) >> 16)
            b = Double((hexNumber & 0x0000ff00) >> 8)
            a = Double(hexNumber & 0x000000ff)
        }
        self.init(.sRGB, red: r / 255, green: g / 255, blue: b / 255, opacity: a / 255)
    }
}
