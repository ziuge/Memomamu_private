//
//  Content.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/08.
//

import Foundation
import RealmSwift

class Diary: Object {
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
    @Persisted var date = Date()
    @Persisted var todo: String?
    @Persisted var check: Int
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(date: Date, todo: String?, check: Int) {
        self.init()
        self.date = date
        self.todo = todo
        self.check = 0
    }
}
