//
//  Formatter+Extension.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/19.
//

import UIKit

//extension UIViewController {
//
//    // MARK: DateFormatter
//    static let formatter: DateFormatter = {
//
//    }()
//
//    func changeDate(date: Date) -> String {
//        return UIViewController.formatter.string(from: date)
//    }
//}

extension DateFormatter {
    static let dateOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd."
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
}
