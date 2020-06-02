//
//  Color.swift
//  Gofun
//
//  Created by 王洪运 on 2019/5/31.
//  Copyright © 2019 sqev. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS)
    import UIKit
    typealias WHYColor = UIColor
#else
    import Cocoa
    typealias WHYColor = NSColor
#endif

/**
 ex.
    1. label.textColor = Color.hex.0xffffff
    2. label.textColor = Color.hex.0xffffff40, alpha = 0.4
 */

@dynamicMemberLookup
enum Color {
    
    case hex
    
    subscript(dynamicMember member: String) -> UIColor {
        switch self {
        case .hex:
            let string = String(member[member.index(member.startIndex, offsetBy: 2)...])
            if string.count <= 6 {
                return UIColor(hexString: string)!
            } else {
                let sepIndex = string.index(string.startIndex, offsetBy: 6)
                let hexStr = String(string[..<sepIndex])
                var alpha = (NumberFormatter().number(from: String(string[sepIndex...]))?.floatValue ?? 0) / 100.0
                while alpha > 1 {
                    alpha = alpha / 10
                }
                return UIColor(hexString: hexStr, alpha: alpha)!
            }
        }
    }
}

/*
 
 Form SwiftHEXColors
 */

private extension Int {
    func duplicate4bits() -> Int {
        return (self << 4) + self
    }
}

/// An extension of UIColor (on iOS) or NSColor (on OSX) providing HEX color handling.
extension WHYColor {
    /**
     Create non-autoreleased color with in the given hex string. Alpha will be set as 1 by default.

     - parameter hexString: The hex string, with or without the hash character.
     - returns: A color with the given hex string.
     */
    convenience init?(hexString: String) {
        self.init(hexString: hexString, alpha: 1.0)
    }

    private convenience init?(hex3: Int, alpha: Float) {
        self.init(red:   CGFloat( ((hex3 & 0xF00) >> 8).duplicate4bits() ) / 255.0,
                  green: CGFloat( ((hex3 & 0x0F0) >> 4).duplicate4bits() ) / 255.0,
                  blue:  CGFloat( ((hex3 & 0x00F) >> 0).duplicate4bits() ) / 255.0,
                  alpha: CGFloat(alpha))
    }

    private convenience init?(hex6: Int, alpha: Float) {
        self.init(red:   CGFloat( (hex6 & 0xFF0000) >> 16 ) / 255.0,
                  green: CGFloat( (hex6 & 0x00FF00) >> 8 ) / 255.0,
                  blue:  CGFloat( (hex6 & 0x0000FF) >> 0 ) / 255.0, alpha: CGFloat(alpha))
    }

    /**
     Create non-autoreleased color with in the given hex string and alpha.

     - parameter hexString: The hex string, with or without the hash character.
     - parameter alpha: The alpha value, a floating value between 0 and 1.
     - returns: A color with the given hex string and alpha.
     */
    convenience init?(hexString: String, alpha: Float) {
        var hex = hexString

        // Check for hash and remove the hash
        if hex.hasPrefix("#") {
            hex = String(hex[hex.index(after: hex.startIndex)...])
        }

        guard let hexVal = Int(hex, radix: 16) else {
            self.init()
            return nil
        }

        switch hex.count {
        case 3:
            self.init(hex3: hexVal, alpha: alpha)
        case 6:
            self.init(hex6: hexVal, alpha: alpha)
        default:
            // Note:
            // The swift 1.1 compiler is currently unable to destroy partially initialized classes in all cases,
            // so it disallows formation of a situation where it would have to.  We consider this a bug to be fixed
            // in future releases, not a feature. -- Apple Forum
            self.init()
            return nil
        }
    }

    /**
     Create non-autoreleased color with in the given hex value. Alpha will be set as 1 by default.

     - parameter hex: The hex value. For example: 0xff8942 (no quotation).
     - returns: A color with the given hex value
     */
    convenience init?(hex: Int) {
        self.init(hex: hex, alpha: 1.0)
    }

    /**
     Create non-autoreleased color with in the given hex value and alpha

     - parameter hex: The hex value. For example: 0xff8942 (no quotation).
     - parameter alpha: The alpha value, a floating value between 0 and 1.
     - returns: color with the given hex value and alpha
     */
    convenience init?(hex: Int, alpha: Float) {
        if (0x000000 ... 0xFFFFFF) ~= hex {
            self.init(hex6: hex, alpha: alpha)
        } else {
            self.init()
            return nil
        }
    }
}
