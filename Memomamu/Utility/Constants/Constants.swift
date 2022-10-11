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
        static let point = UIColor(red: (171/255.0), green: (214/255.0), blue: (0/255.0), alpha: 1)
    }
    
    enum Language {
        static let korean = "DungGeunMo"
    }
    
    enum Font {
        static let head = UIFont(name: "DungGeunMo", size: 24)
        static let title = UIFont(name: "DungGeunMo", size: 20)
        static let cardTitle = UIFont(name: "DungGeunMo", size: 18)
        static let content = UIFont(name: "DungGeunMo", size: 15)
        static let button = UIFont(name: "DungGeunMo", size: 15)
        static let smallContent = UIFont(name: "DungGeunMo", size: 14)
    }
}
