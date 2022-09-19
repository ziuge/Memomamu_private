//
//  Content.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/08.
//

import Foundation
import RealmSwift

class Diary: Object {
    @Persisted var date: String // 날짜
    @Persisted var diary: String?
    @Persisted var hasChanged: Bool
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(date: String, diary: String?, hasChanged: Bool) {
        self.init()
        self.date = date
        self.diary = diary
        self.hasChanged = false
    }
}

class Todo: Object {
    @Persisted var date: String // Todo 작성 날짜
    @Persisted var orderDate: Date // 순서 변경을 위한 날짜 데이터 받아오기
    @Persisted var todo: String?
    @Persisted var check: Int
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(date: String, orderDate: Date, todo: String?, check: Int) {
        self.init()
        self.date = date
        self.orderDate = orderDate
        self.todo = todo
        self.check = 0
    }
}
