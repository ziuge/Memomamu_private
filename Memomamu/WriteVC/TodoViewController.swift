//
//  TodoViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/13.
//

import UIKit
import RealmSwift

class TodoViewController: UIViewController {
    
    // MARK: Realm
    let repository = Repository()
    var todos: Results<Todo>! {
        didSet {
            tableView.reloadData()
        }
    }
    func fetchRealm() {
        todos = repository.fetchTodo()
        tableView.reloadData()
    }
    
    // MARK: DateFormatter
//    let formatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy. MM. dd."
//        formatter.locale = Locale(identifier: "ko_KR")
//        return formatter
//    }()

//    func changeDate(date: Date) -> String {
//        return formatter.string(from: date)
//    }
    
    var todayDate: String = ""
    

    // MARK: UI
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
    var editButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "todayButton.jpg"), for: .normal)
        view.tintColor = Constants.Color.text
        return view
    }()
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = Constants.Color.paper
        view.delegate = self
        view.dataSource = self
        view.register(WriteTableViewCell.self, forCellReuseIdentifier: WriteTableViewCell.reuseIdentifier)
        view.separatorStyle = .none
        return view
    }()
    var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.paper
        return view
    }()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        todayDate = DateFormatter.dateOnly.string(from: Date())
        fetchRealm()
        configure()
        setConstraints()
        editButton.addTarget(self, action: #selector(editMode), for: .touchUpInside)
    }
    
    func configure() {
        view.addSubview(backgroundView)
        [tableView, titleLabel, lineImageView, editButton].forEach {
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
        
        editButton.snp.makeConstraints { make in
            make.topMargin.equalTo(backgroundView).offset(20)
            make.trailingMargin.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.width.equalTo(21)
        }
        
        tableView.snp.makeConstraints { make in
            make.trailing.equalTo(backgroundView)
            make.leading.equalTo(backgroundView).offset(40)
//            make.bottom.equalTo(backgroundView.safeAreaLayoutGuide).offset(50)
            make.height.equalTo(backgroundView.snp.height).multipliedBy(0.48)
            make.topMargin.equalTo(lineImageView.snp.bottom).offset(12)
        }
        print(self, tableView.snp.height)
    }
    
    func scrollToBottom(){
        let lastRowOfIndexPath = self.tableView.numberOfRows(inSection: 0) - 1
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: lastRowOfIndexPath, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

// MARK: - TableView

extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        } else {
            return todos.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, indexPath)
        if indexPath.section == 1 && self.tableView.isEditing == false {
            repository.addTodo(item: Todo(date: todayDate, orderDate: Date() , todo: "\(Int.random(in: 1...100))", check: 0))
            
            fetchRealm()
            
        } else {
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function, indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WriteTableViewCell.reuseIdentifier, for: indexPath) as? WriteTableViewCell else { return UITableViewCell() }
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(addTodo))
        if indexPath.section == 0 {
            cell.setData(data: todos[indexPath.row])
//            cell.todoTextView.clearsOnInsertion = true
            cell.todoTextView.delegate = self
            cell.todoTextView.isEditable = true
            cell.todoTextView.isUserInteractionEnabled = true
//            cell.todoTextView.removeGestureRecognizer(tap)
            return cell
        } else {
            cell.todoTextView.textColor = Constants.Color.background.withAlphaComponent(0.8)
            cell.checkButton.setImage(UIImage(named: "addTodoButton"), for: .normal)
            cell.todoTextView.isEditable = false
            cell.todoTextView.text = "할 일 적으삼"
//            cell.todoTextView.tag = indexPath.row
//            cell.todoTextView.isHidden = true
//            cell.todoTextView.isUserInteractionEnabled = true
//            cell.todoTextView.addGestureRecognizer(tap)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath == [1, 0] {
            return .none
        } else {
            return .delete
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            print("delete")
            repository.deleteTodo(item: todos[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc func addTodo() {
        print(#function)
        repository.addTodo(item: Todo(date: todayDate, orderDate: Date(), todo: "\(Int.random(in: 100...999))", check: 0))
        tableView.reloadData()
    }
    
    @objc func editMode() {
        if self.tableView.isEditing {
            self.tableView.setEditing(false, animated: true)
            
        } else {
            self.tableView.setEditing(true, animated: true)
        }
    }
    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let delete = UIContextualAction(style: .normal, title: "삭제") { action, view, completionHandler in
//            self.repository.deleteTodo(item: self.todos[indexPath.row])
//        }
//        delete.image = UIImage(systemName: "trash")
//        delete.backgroundColor = .systemRed
//
//        return UISwipeActionsConfiguration(actions: [delete])
//    }
}

// MARK: - textView Delegate
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
