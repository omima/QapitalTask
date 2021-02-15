//
//  UIView+CornerRadius.swift
//  QapitalTask
//
//  Created by Omima Ibrahim on 15/02/2021.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius}
        set {
            layer.cornerRadius =  newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
