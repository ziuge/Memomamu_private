//
//  File.swift
//  Memomamu
//
//  Created by CHOI on 2023/03/07.
//

import Foundation
import RealmSwift

class Notification: Object {
    @Persisted var notiTodo: Bool
    @Persisted var notiDiary: Bool
    @Persisted var timeTodo: String
    @Persisted var timeDiary: String
}
