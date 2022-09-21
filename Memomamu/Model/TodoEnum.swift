//
//  TodoEnum.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/18.
//

enum check: Int {
    case unchecked
    case finished
    case delayed
    case unfinished
    
    var checkInfo: String {
        String(describing: self)
    }
}
