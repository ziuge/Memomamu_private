//
//  CheckModel.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/26.
//

import Foundation

class CheckModel {
    var check: Observable<Int> = Observable(0)
    var allChecked: Observable<Bool> = Observable(true)
    
    func checkClear() {
        if check.value == 0 {
            allChecked.value = false
        }
    }
}
