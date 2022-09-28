//
//  Formatter+Extension.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/19.
//

import UIKit

extension DateFormatter {
    static let dateOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd."
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    static let titleDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d, MMMM"
//        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
}
