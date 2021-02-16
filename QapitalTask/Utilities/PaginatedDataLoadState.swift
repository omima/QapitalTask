//
//  PaginatedDataLoadState.swift
//  QapitalTask
//
//  Created by Omima Ibrahim on 16/02/2021.
//

import Foundation

enum PaginatedDataLoadState<T: Equatable> {
    case notLoaded
    case loading
    case paging([T], nextPage: (from : Date, to: Date))
    case populated([T])
    
    var data: [T] {
        switch self {
        case .paging(let data, _ ):
            return data
        case .populated(let data):
            return data
        case .loading, .notLoaded:
            return []
        }
    }
    
    var nextPage:  (from : Date, to: Date) {
        switch self {
        case .paging(_, let nextPage):
            return nextPage
        case .populated(_):
            return ( DateManager.shared.getTwoWeeks(from: Date()), Date())
        case .loading, .notLoaded:
            return (DateManager.shared.getTwoWeeks(from: Date()), Date())
        }
    }
    
    var isEmpty: Bool {
        switch self {
        case .paging(let data, _ ):
            return data.isEmpty
        case .populated(let data):
            return data.isEmpty
        case .loading, .notLoaded:
            return false
        }
    }
    
    var hasNextPage: Bool {
        switch self {
        case .paging(_, _ ):
            return true
        case .populated(_):
            return false
        case .loading, .notLoaded:
            return true
        }
    }
    
    var isPopulated: Bool {
        switch self {
        case .paging(_, _ ):
            return false
        case .populated(_):
            return true
        case .loading, .notLoaded:
            return false
        }
    }
    
    var isLoading: Bool {
        switch self {
        case .paging(_, _ ):
            return false
        case .populated(_):
            return false
        case .loading:
            return true
        case .notLoaded:
            return false
        }
    }
    
    mutating func addNewItem(item: T) {
        guard !self.data.contains(item) else { return }
        var newData = self.data
        newData.insert(item, at: 0)
        
        switch self {
        case .paging(_,let nextPage):
            self = .paging(newData , nextPage: nextPage)
        case .populated(_):
            self = .populated(newData + data)
        default: break
        }
    }
}
