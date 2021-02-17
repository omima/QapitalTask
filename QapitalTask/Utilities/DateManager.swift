//
//  DateManager.swift
//  QapitalTask
//
//  Created by Omima Ibrahim on 16/02/2021.
//

import Foundation

class DateManager : NSObject  {
    
    static let shared = DateManager()
    
    func getTwoWeeks(from date : Date) -> Date {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let twoWeeksAfter = calendar?.date(byAdding: NSCalendar.Unit.day, value: -14, to: date, options: NSCalendar.Options.matchLast)
        
        return twoWeeksAfter ?? Date()
    }
    
    func convertDateToString(date :Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    func convertDateString(with string : String) -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: string)!
        dateFormatter.dateFormat = "d MMM yyyy"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    func convertStringToDate(_ date : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateString = dateFormatter.date(from: date) ?? Date()
        return dateString
    }
}
