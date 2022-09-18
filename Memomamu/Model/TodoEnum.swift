//
//  TodoEnum.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/18.
//

enum check: Int {
    case unchecked = 0
    case finished = 1
    case delayed = 2
    case unfinished = 3
    
    var checkInfo: String {
        switch self {
        case .unchecked:
            return "todoButton-unchecked"
        case.finished:
            return "todoButton-checked-orange"
        case .delayed:
            return "todoButton-delayed"
        case .unfinished:
            return "todoButton-unfinished"
        }
    }
}
