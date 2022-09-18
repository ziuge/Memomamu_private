//
//  Repository.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/18.
//

import RealmSwift

protocol ContentRepositoryType {
    func addTodo(item: Todo)
    func updateTodo(oldValue: Todo, newValue: String)
}

class Repository: ContentRepositoryType {
    let localRealm = try! Realm()
    
    func addTodo(item: Todo) {
        let item = item
        do {
            try localRealm.write({
                localRealm.add(item)
                print(#function, "realm success")
            })
        } catch {
            print(error)
        }
    }
    
    func updateTodo(oldValue: Todo, newValue: String) {
        do {
            try localRealm.write({
                oldValue.todo = newValue
            })
        } catch {
            print(error)
        }
    }
    
    func checkTodo(item: Todo) {
//        item.check
    }
    
}
