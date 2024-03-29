//
//  Repository.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/18.
//

import RealmSwift
import Foundation

protocol ContentRepositoryType {
    func fetchTodo(date: String) -> Results<Todo>
    func addTodo(item: Todo)
    func updateTodo(oldValue: Todo, newValue: String)
    func checkTodo(item: Todo, status: Int)
}

class Repository: ContentRepositoryType {
    let localRealm = try! Realm()
    
    func fetchEveryTodo() -> Results<Todo> {
        return localRealm.objects(Todo.self)
    }
    
    func fetchEveryDiary() -> Results<Diary> {
        return localRealm.objects(Diary.self)
    }
    
    func fetchTodo(date: String) -> Results<Todo> {
        print(localRealm.configuration.fileURL!)
        do {
            let version = try schemaVersionAtURL(localRealm.configuration.fileURL!) // 이 URL에 들어있는 스키마의 버전을 알려줌
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
        return localRealm.objects(Todo.self).filter("date == %@", date).sorted(byKeyPath: "orderDate", ascending: true)
    }
    
    func fetchDiary(date: String) -> Diary? {
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
        guard let diary = localRealm.objects(Diary.self).filter("date == %@", date).first else { return nil }
        
        return diary
    }
    
    func addTodo(item: Todo) {
        let item = item
        do {
            try localRealm.write({
                localRealm.add(item)
            })
        } catch {
            print(error)
        }
    }
    
    func addDiary(item: Diary) {
        let item = item
        do {
            try localRealm.write({
                localRealm.add(item)
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
    
    func updateTodoCheck(oldValue: Todo, newValue: Int) {
        do {
            try localRealm.write({
                oldValue.check = newValue
            })
        } catch {
            print(error)
        }
    }
    
    func updateTodoColor(oldValue: Todo, newValue: Int) {
        do {
            try localRealm.write({
                oldValue.color = newValue
            })
        } catch {
            print(error)
        }
    }
    
    func updateTodoOrder(oldValue: Todo, newValue: Date) {
        do {
            try localRealm.write({
                oldValue.orderDate = newValue
            })
        } catch {
            print(error)
        }
    }
    
    func updateDiary(oldValue: Diary, newValue: String) {
        do {
            try localRealm.write({
                oldValue.diary = newValue
            })
        } catch {
            print(error)
        }
    }
    
    func checkTodo(item: Todo, status: Int) {
        do {
            try localRealm.write({
                item.check = status
            })
        } catch {
            print(error)
        }
    }
    
    func deleteTodo(item: Todo) {
        do {
            try localRealm.write({
                localRealm.delete(item)
            })
        } catch {
            print(error)
        }
    }
    
    func deleteDiary(item: Diary) {
        do {
            try localRealm.write({
                localRealm.delete(item)
            })
        } catch {
            print(error)
        }
    }
    
}
