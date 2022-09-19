//
//  Repository.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/18.
//

import RealmSwift
import Foundation

protocol ContentRepositoryType {
    func fetchTodo() -> Results<Todo>
    func addTodo(item: Todo)
    func updateTodo(oldValue: Todo, newValue: String)
    func checkTodo(item: Todo, status: Int)
}

class Repository: ContentRepositoryType {
    let localRealm = try! Realm()
    
    func fetchTodo() -> Results<Todo> {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        return localRealm.objects(Todo.self).sorted(byKeyPath: "date", ascending: true)
    }
    
    func fetchDiary(date: String) -> Diary {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        print(#function, "Diary!")
        
        return localRealm.objects(Diary.self).filter("date == %@", date).first!
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
        print(#function)
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
    
    func diaryChanged(item: Diary) {
        do {
            try localRealm.write({
                item.hasChanged.toggle()
            })
        } catch {
            print(error)
        }
    }
    
}
