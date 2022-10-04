//
//  TodoViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/13.
//

import UIKit
import RealmSwift

class TodoViewController: UIViewController {
    
    var selectedDate: String = DateFormatter.dateOnly.string(from: Date())
    var arrIndexPath = [IndexPath]() {
        didSet {
            print(arrIndexPath)
        }
    }
    
    // MARK: Realm
    let repository = Repository()
    var todos: Results<Todo>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    func fetchRealm() {
        todos = repository.fetchTodo(date: selectedDate)
        tableView.reloadData()
    }
    
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
        view.setImage(UIImage(systemName: "minus.square"), for: .normal)
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
        view.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
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
        view.backgroundColor = Constants.Color.background
        
        fetchRealm()
        configure()
        setConstraints()
//        editButton.addTarget(self, action: #selector(editMode), for: .touchUpInside)
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
            make.height.equalTo(view.snp.height).multipliedBy(0.85)
            make.top.trailing.equalTo(view)
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
            make.trailing.equalTo(backgroundView)
            make.leading.equalTo(backgroundView).offset(40)
            make.bottom.equalTo(backgroundView.safeAreaLayoutGuide)
            make.top.equalTo(lineImageView.snp.bottom)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WriteTableViewCell.reuseIdentifier, for: indexPath) as? WriteTableViewCell else { return UITableViewCell() }
        
        cell.checkButton.isEnabled = true
        
        if indexPath.section == 0 {
            cell.setData(data: todos[indexPath.row])
            cell.todoTextView.delegate = self
            cell.todoTextView.isEditable = true
            cell.todoTextView.textColor = Constants.Color.background
            
            cell.selectionStyle = .none
            
            cell.finishedButton.tag = indexPath.row
            cell.finishedButton.addTarget(self, action: #selector(changeCheck(sender:)), for: .touchUpInside)
            
            cell.delayedButton.tag = indexPath.row
            cell.delayedButton.addTarget(self, action: #selector(changeCheckDelayed(sender:)), for: .touchUpInside)
            cell.unfinishedButton.tag = indexPath.row
            cell.unfinishedButton.addTarget(self, action: #selector(changeCheckUnfinished(sender:)), for: .touchUpInside)
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(deleteButtonClicked(sender:)), for: .touchUpInside)
            
            cell.changeCheckView.isHidden = false
            
            let checkList = ["unchecked", "finished", "delayed", "unfinished"]
            let check = todos[indexPath.row].check
            let color = todos[indexPath.row].color
            
            if checkList[check] == "finished" {
                cell.checkButton.setImage(UIImage(named: "finished-\(color)-o"), for: .normal)
            } else if checkList[check] != "unchecked" {
                cell.checkButton.setImage(UIImage(named: "\(checkList[check])-o"), for: .normal)
            }
//            cell.checkButton.setImage(UIImage(named: checkList[checkNum]), for: .normal)
            cell.checkButton.tag = indexPath.row
            cell.checkButton.addTarget(self, action: #selector(showChangeCheck(sender:)), for: .touchUpInside)
            
            cell.clickButton.isHidden = true
            
            return cell
        } else {
            cell.todoTextView.textColor = Constants.Color.background.withAlphaComponent(0.8)
            cell.checkButton.setImage(UIImage(named: "addTodoButton"), for: .normal)
            cell.todoTextView.isEditable = false
            cell.todoTextView.text = NSLocalizedString("WriteTodo", comment: "할 일 작성 문구")
            cell.todoTextView.tag = indexPath.row
            cell.selectionStyle = .none
            cell.changeCheckView.isHidden = false
            cell.clickButton.isHidden = false
            cell.clickButton.addTarget(self, action: #selector(addTodo), for: .touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if arrIndexPath.contains(indexPath) == false {
            cell.alpha = 0
            let transform = CATransform3DTranslate(CATransform3DIdentity, 40, 0, 0)
            cell.layer.transform = transform
            
            UIView.animate(withDuration: 0.5, delay: 0.03 * Double(indexPath.row + (indexPath.section * 8)), usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                cell.alpha = 1
                cell.layer.transform = CATransform3DIdentity
            })
            
            arrIndexPath.append(indexPath)
        }
    }
    
    // MARK: Change Check
    
    @objc func showChangeCheck(sender: UIButton) {
        tableView.reloadData()
        
        let cell: WriteTableViewCell = tableView.cellForRow(at: [0, sender.tag]) as! WriteTableViewCell
        cell.changeCheckView.isHidden.toggle()
    }
    
    @objc func changeCheck(sender: UIButton) {
        repository.updateTodoCheck(oldValue: todos[sender.tag], newValue: 1)
        repository.updateTodoColor(oldValue: todos[sender.tag], newValue: Int.random(in: 0...11))
        let cell: WriteTableViewCell = tableView.cellForRow(at: [0, sender.tag]) as! WriteTableViewCell
        cell.changeCheckView.isHidden = false
        fetchRealm()
    }
    
    @objc func changeCheckDelayed(sender: UIButton) {
        repository.updateTodoCheck(oldValue: todos[sender.tag], newValue: 2)
        let cell: WriteTableViewCell = tableView.cellForRow(at: [0, sender.tag]) as! WriteTableViewCell
        cell.changeCheckView.isHidden = false
        fetchRealm()
    }
    
    @objc func changeCheckUnfinished(sender: UIButton) {
        repository.updateTodoCheck(oldValue: todos[sender.tag], newValue: 3)
        let cell: WriteTableViewCell = tableView.cellForRow(at: [0, sender.tag]) as! WriteTableViewCell
        cell.changeCheckView.isHidden = false
        fetchRealm()
    }
    
    @objc func deleteButtonClicked(sender: UIButton) {
        repository.deleteTodo(item: todos[sender.tag])
        arrIndexPath = arrIndexPath.filter({ indexPath in
            indexPath != IndexPath(row: todos.count, section: 0)
        })
        
        if let diary = repository.fetchDiary(date: selectedDate) {
            if todos.count == 0 && (diary.diary == "" || diary.diary == nil) {
                repository.deleteDiary(item: diary)
            }
        }
        
        fetchRealm()
    }
    
    @objc func addTodo() {
        repository.addTodo(item: Todo(date: selectedDate, orderDate: Date(), todo: "", check: 0, color: 0))
        if repository.fetchDiary(date: selectedDate) == nil {
            repository.addDiary(item: Diary(date: selectedDate, diary: nil))
        }
        
        fetchRealm()
        let index = IndexPath(row: todos.count - 1, section: 0)
        let cell: WriteTableViewCell = self.tableView.cellForRow(at: index) as! WriteTableViewCell
        cell.todoTextView.becomeFirstResponder()
    }
//
//    @objc func editMode() {
//        if self.tableView.isEditing {
//            self.tableView.setEditing(false, animated: true)
//        } else {
//            self.tableView.setEditing(true, animated: true)
//        }
//    }
    
}

// MARK: - textView Delegate
extension TodoViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let contentSize = textView.sizeThatFits(CGSize(width: textView.bounds.width, height: .infinity))
        if textView.bounds.height != contentSize.height {
            tableView.contentOffset.y += contentSize.height - textView.bounds.height
            UIView.setAnimationsEnabled(false)
            tableView.beginUpdates()
            tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let pointInTable = textView.convert(textView.bounds.origin, to: self.tableView)
        guard let textViewIndexPath = self.tableView.indexPathForRow(at: pointInTable) else { return }
        guard let cell: WriteTableViewCell = self.tableView.cellForRow(at: textViewIndexPath) as? WriteTableViewCell else { return }
        cell.changeCheckView.isHidden = false
        cell.checkButton.isEnabled = false
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        let pointInTable = textView.convert(textView.bounds.origin, to: self.tableView)
        guard let textViewIndexPath = self.tableView.indexPathForRow(at: pointInTable) else { return }
        
        guard let cell: WriteTableViewCell = self.tableView.cellForRow(at: textViewIndexPath) as? WriteTableViewCell else { return }
        if cell.todoTextView.text.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            repository.deleteTodo(item: todos[textViewIndexPath.row])
            arrIndexPath = arrIndexPath.filter({ indexPath in
                indexPath != IndexPath(row: todos.count, section: 0)
            })
            if let diary = repository.fetchDiary(date: selectedDate) {
                if todos.count == 0 && (diary.diary == "" || diary.diary == nil) {
                    repository.deleteDiary(item: diary)
                }
            }
        } else {
            repository.updateTodo(oldValue: todos[textViewIndexPath.row], newValue: textView.text)
        }
        fetchRealm()
    }
    
}

// MARK: Gesture Recognizer
extension TodoViewController: UIGestureRecognizerDelegate {
    
}
