//
//  Observable.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/20.
//

class Observable<T> { // 데이터 담아주는 역할을 할 것. 양방향 바인딩 가능하게끔 만들 것
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("didset", value)
            listener?(value) // 3. didSet에서 업데이트
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        print(#function)
        closure(value) // 1. 코드 실행 후
        listener = closure // 2. 같은 코드가 계속 실행될 수 있도록 listener에 담아주고
    }
}

