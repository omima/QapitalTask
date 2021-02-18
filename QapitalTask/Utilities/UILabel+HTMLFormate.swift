//
//  UILabel+HTMLFormate.swift
//  QapitalTask
//
//  Created by Omima Ibrahim on 17/02/2021.
//

import Foundation
import UIKit

extension String {
    
    func htmlAttributed(size: CGFloat) -> NSAttributedString? {
        let htmlTemplate =
            """
        <!doctype html>
        <html>
          <head>
            <style>
              body {
                color: #8F96A3;
                font-family: BentonSans-Regular;
                 font-size: \(size)px;
              }
            strong {
                color: #000000;
                font-family: BentonSans-Regular;
                font-weight: normal;
                font-size: \(size)px;
            }
            </style>
          </head>
          <body>
            \(self)
          </body>
        </html>
        """

        guard let data = htmlTemplate.data(using: .utf8) else {
            return nil
        }

        guard let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html,.characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil
            ) else {
            return nil
        }

        return attributedString
    }
}
//                color: \(color.hexString!);

extension UIColor {
    var hexString:String? {
        if let components = self.cgColor.components {
            let r = components[0]
            let g = components[1]
            let b = components[2]
            return  String(format: "#%02x%02x%02x", (Int)(r * 255), (Int)(g * 255), (Int)(b * 255))
        }
        return nil
    }
}


