import Foundation
import SwiftUI

extension Font {
    enum ArabicFont {
        case ramadhankarimFont
        case persianFont
        case alladinFont
        case bulanRamadhanFont
        case custom(String)
        
        var value: String {
            switch self {
            case .ramadhankarimFont: 
                return "Ramadhan Karim"
            case .persianFont: 
                return "Persian"
            case .alladinFont: 
                return "Alladhina-Demo"
            case .bulanRamadhanFont:
                return "Bulan Ramadhan"
            case .custom(let string):
                return string
            }
        }
    }
    
    static func arabic(_ type: ArabicFont, _ size: CGFloat) -> Font {
        return .custom(type.value, size: size)
      }
}
