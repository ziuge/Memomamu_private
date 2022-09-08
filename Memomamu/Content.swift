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
    @Persisted var todoList: List<Todo> // todo리스트
    @Persisted var diary: String?
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(date: Date, todoList: List<Todo>, diary: String?) {
        self.init()
        self.date = date
        self.todoList = todoList
        self.diary = diary
    }
}

class Todo: Object {
    @Persisted var todo: String
    @Persisted var check: Bool
    
    convenience init(todo: String, check: Bool) {
        self.init()
        self.todo = todo
        self.check = false
    }
}
