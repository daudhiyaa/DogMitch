//
//  Color.swift
//  MC3
//
//  Created by Marsha Likorawung on 15/07/24.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        let rgbValue = UInt32(hex, radix: 16)
        let r = Double((rgbValue! & 0xFF0000) >> 16) / 255
        let g = Double((rgbValue! & 0x00FF00) >> 8) / 255
        let b = Double(rgbValue! & 0x0000FF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

class Colors {
    static let tosca = Color(hex: "#06CACD")
    static let yellow = Color(hex: "#FABC07")
    static let lightpink = Color(hex: "#FF5353")
    static let brown = Color(hex: "#B78905")
    static let gray = Color(hex: "#D9D9D9")
}
