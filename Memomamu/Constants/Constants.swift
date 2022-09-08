//
//  Constants.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/08.
//

import UIKit

enum Constants {
    enum Color {
        static let background = UIColor(red: 0x61, green: 0x78, blue: 0xDC, alpha: 1)
        static let text = UIColor(red: 0xF9, green: 0x95, blue: 0x19, alpha: 1)
        static let paper = UIColor(red: 0xFC, green: 0xF8, blue: 0xF5, alpha: 1)
    }
    
    enum Font {
        static let head = UIFont.systemFont(ofSize: 24, weight: .heavy)
        static let title = UIFont.systemFont(ofSize: 20, weight: .bold)
        static let content = UIFont.systemFont(ofSize: 15, weight: .medium)
        static let button = UIFont.systemFont(ofSize: 15, weight: .medium)
    }
}
