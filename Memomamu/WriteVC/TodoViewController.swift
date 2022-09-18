//
//  TodoViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/13.
//

import UIKit
import RealmSwift

class TodoViewController: UIViewController {
    
    let localRealm = try! Realm()
    var todos: Results<Todo>! {
        didSet {
            tableView.reloadData()
        }
    }
//    var todos: [Todo] = [Todo(todo: "하이하이", check: 0, num: 0), Todo(todo: "바이바이", check: 0, num: 1), Todo(todo: "sdfbn", check: 1, num: 2)]
    
    var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "to do list"
        view.font = Constants.Font.title
        view.textColor = Constants.Color.background
        return view
    }()
    
    var lineImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "todoLine")
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = Constants.Color.paper
        view.delegate = self
        view.dataSource = self
        view.register(WriteTableViewCell.self, forCellReuseIdentifier: WriteTableViewCell.reuseIdentifier)
        return view
    }()
    
    var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.paper
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
        configure()
        setConstraints()
    }
    
    func configure() {
        view.addSubview(backgroundView)
        [tableView, titleLabel, lineImageView].forEach {
            backgroundView.addSubview($0)
        }
    }
    
    func setConstraints() {
        
        let spacing = 16
        
        backgroundView.snp.makeConstraints { make in
            make.width.equalTo(Int(view.frame.width) - spacing)
            make.rightMargin.equalTo(spacing)
            make.height.equalTo(view.frame.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.topMargin.equalTo(backgroundView).offset(36)
        }
        
        lineImageView.snp.makeConstraints { make in
            make.width.equalTo(backgroundView).multipliedBy(0.768)
            make.centerX.equalTo(backgroundView)
            make.height.equalTo(1)
            make.top.equalTo(titleLabel.snp.bottom).offset(19)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(backgroundView.safeAreaLayoutGuide)
            make.topMargin.equalTo(lineImageView.snp.bottom).offset(12)
        }
    }
    
    func addCell(num: Int) {
//        todos.append(Todo(todo: "", check: 0, num: num))
        
    }

}

// MARK: - TableView

extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? 1 : todos.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            addCell(num: todos.count)
            tableView.reloadData()
        }
        
//        if indexPath.section == 1 {
//            todos.append(Todo(todo: "TODO\(indexPath.row)", check: 0, num: todos.count))
//            print("todos", todos)
//            tableView.reloadData()
//        } else {
//            print("selected", indexPath.row)
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WriteTableViewCell.reuseIdentifier, for: indexPath) as? WriteTableViewCell else { return UITableViewCell() }
            cell.todoTextView.text = todos[indexPath.row].todo
            cell.todoTextView.clearsOnInsertion = true
            cell.todoTextView.delegate = self
            
            return cell
        } else {
            let cell = UITableViewCell()
            cell.backgroundColor = .blue
            return cell
        }
    
    }
}

extension TodoViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print(String(describing: textView.text))
        
        let contentSize = textView.sizeThatFits(CGSize(width: textView.bounds.width, height: .infinity))
        if textView.bounds.height != contentSize.height {
            tableView.contentOffset.y += contentSize.height - textView.bounds.height
            UIView.setAnimationsEnabled(false)
            tableView.beginUpdates()
            tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
        }
    }
}
