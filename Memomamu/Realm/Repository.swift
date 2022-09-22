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
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        return localRealm.objects(Todo.self).sorted(byKeyPath: "orderDate", ascending: true).filter("date == %@", date)
    }
    
    func fetchDiary(date: String) -> Diary? {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        print(#function, "Diary!")
        
        guard let diary = localRealm.objects(Diary.self).filter("date == %@", date).first else { return nil }
        
        return diary
    }
    
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
    
    func addDiary(item: Diary) {
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
    
    func updateTodoCheck(oldValue: Todo, newValue: Int) {
        do {
            try localRealm.write({
                oldValue.check = newValue
            })
        } catch {
            print(error)
        }
    }
    
    func updateDiary(oldValue: Diary, newValue: String) {
        print(#function)
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
    
}
