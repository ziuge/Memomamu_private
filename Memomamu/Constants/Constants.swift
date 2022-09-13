//
//  Constants.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/08.
//

import UIKit

enum Constants {
    enum Color {
        static let background = UIColor(red: (97/255.0), green: (120/255.0), blue: (220/255.0), alpha: 1)
        static let text = UIColor(red: (249/255.0), green: (149/255.0), blue: (25/255.0), alpha: 1)
        static let paper = UIColor(red: (252/255.0), green: (248/255.0), blue: (245/255.0), alpha: 1)
    }
    
    enum Font {
        static let head = UIFont.systemFont(ofSize: 24, weight: .heavy)
        static let title = UIFont.systemFont(ofSize: 20, weight: .bold)
        static let content = UIFont.systemFont(ofSize: 15, weight: .medium)
        static let button = UIFont.systemFont(ofSize: 15, weight: .medium)
    }
}
