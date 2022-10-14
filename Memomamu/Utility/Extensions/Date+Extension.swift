//
//  Date+Extension.swift
//  Memomamu
//
//  Created by CHOI on 2022/10/14.
//

import UIKit

extension UIViewController {
    func stringToDate(string: String) -> Date {
        let selectedDate = string
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd."
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        formatter.locale = Locale(identifier: "en_US")
        let date = formatter.date(from: selectedDate)!
        return date
    }
    
    func dateToString(date: Date) -> String {
        let date = date
        let formatter = DateFormatter()
        formatter.dateFormat = "d, MMMM"
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        formatter.locale = Locale(identifier: "en_US")
        let string = formatter.string(from: date)
        return string
    }
    
    func nextDay(string: String) -> String {
        var rawDate = stringToDate(string: string)
        rawDate.addTimeInterval(86400)
        let string = dateToString(date: rawDate)
        print(#function, string)
        return string
    }
}
