//
//  Colors.swift
//  ABAClone
//
//  Created by Sao Sophea on 10/8/23.
//

import SwiftUI

enum Colors {
    case appBg
    case softText
    case textColor
    case widgetFrameColor
    case blueLight
    case grayText
    case eyeBg
    case discoveryFrame
    
    var value: Color {
        var colorValue: Color!
        
        switch self {
        case .appBg:
            colorValue = Color("appBg")
        case .softText:
            colorValue = Color("softText")
        case .textColor:
            colorValue = Color("textColor")
        case .widgetFrameColor:
            colorValue = Color("widgetFrameColor")
        case .blueLight:
            colorValue = Color("blueLight")
        case .grayText:
            colorValue = Color("grayText")
        case .eyeBg:
            colorValue = Color("eyeBg")
        case .discoveryFrame:
            colorValue = Color("discoveryFrame")
        }
        return colorValue
    }
}
