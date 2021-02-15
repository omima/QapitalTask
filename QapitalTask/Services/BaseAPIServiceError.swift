//
//  BaseAPIServiceError.swift
//  QapitalTask
//
//  Created by Omima Ibrahim on 14/02/2021.
//

import Foundation

enum BaseAPIServiceError: LocalizedError {
    case parsingError
    case serverError(message: String)
    case networkError
    var errorDescription: String? {
        switch self {
        case .parsingError: return "JSON Parsing Failure"
        case .serverError(let message): return "\(message)"
        case .networkError: return "Oops no signal! check your internet connection"
        }
    }
}
