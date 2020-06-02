//
//  Font.swift
//  Gofun
//
//  Created by 王洪运 on 2019/5/31.
//  Copyright © 2019 sqev. All rights reserved.
//

import Foundation
import UIKit

/**
 ex. label.font = Font.bold.15
*/
@dynamicMemberLookup
enum Font {
    
    case system             // 系统
    case bold               // 系统粗体
    case name(String)       // 根据字体名创建
    
    subscript(dynamicMember member: String) -> UIFont {
        return font(size: CGFloat(NumberFormatter().number(from: member)?.floatValue ?? 0))
    }
    
    func font(size: CGFloat) -> UIFont {
        switch self {
        case .system:
            return UIFont.systemFont(ofSize: size)
        case .bold:
            return UIFont.boldSystemFont(ofSize: size)
        case .name(let fontName):
            #if DEBUG
            return UIFont(name: fontName, size: size)!
            #else
            return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
            #endif
        }
    }
}
