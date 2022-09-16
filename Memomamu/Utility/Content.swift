//
//  Content.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/08.
//

import Foundation
import RealmSwift

class Content: Object {
    @Persisted var date = Date() // 날짜
    @Persisted var diary: String?
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(date: Date, diary: String?) {
        self.init()
        self.date = date
        self.diary = diary
    }
}

class Todo: Object {
    @Persisted var todo: String
    @Persisted var check: Int
    @Persisted var num: Int
    
    convenience init(todo: String, check: Int, num: Int) {
        self.init()
        self.todo = todo
        self.check = 0
        self.num = num
    }
}
