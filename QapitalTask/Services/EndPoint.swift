//
//  EndPoint.swift
//  QapitalTask
//
//  Created by Omima Ibrahim on 14/02/2021.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var base: String { get }
}

extension Endpoint {
    var base: String {
        return "http://qapital-ios-testtask.herokuapp.com"
    }
}
