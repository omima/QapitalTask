//
//  Font.swift
//  QapitalTask
//
//  Created by Omima Ibrahim on 17/02/2021.
//

import UIKit

extension UIFont {
    static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "BentonSans-Bold", size: size)!
    }
    
    static func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "BentonSans-Regular", size: size)!
    }
    
    static func semiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "BentonSans-Medium", size: size)!
    }
    
}

