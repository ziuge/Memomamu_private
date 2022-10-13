//
//  Diary.swift
//  Memomamu
//
//  Created by CHOI on 2022/10/13.
//

import Foundation
import RealmSwift

class Diary: Object {
    @Persisted var date: String // 날짜
    @Persisted var diary: String?
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(date: String, diary: String?) {
        self.init()
        self.date = date
        self.diary = diary
    }
}
