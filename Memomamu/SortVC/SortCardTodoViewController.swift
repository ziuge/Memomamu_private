//
//  SortCardTodoViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/27.
//

import UIKit
import RealmSwift

class SortCardTodoViewController: BaseViewController {
    
    var selectedDate = DateFormatter.dateOnly.string(from: Date())
    
    // MARK: Realm
    let repository = Repository()
    var todos: Results<Todo>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    var nav = UINavigationController()
    
    func fetchRealm(date: String) {
        todos = repository.fetchTodo(date: date)
        tableView.reloadData()
        if todos.count == 0 {
            todoNilLabel.isHidden = false
            tableView.isHidden = true
        } else {
            todoNilLabel.isHidden = true
            tableView.isHidden = false
        }
    }
    
    // MARK: UI
    var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "to do list"
        view.font = Constants.Font.cardTitle
        view.textColor = Constants.Color.background
        view.textAlignment = .left
        return view
    }()
    var todoNilLabel: UILabel = {
        let view = UILabel()
        view.text = NSLocalizedString("WriteTodo", comment: "할 일 작성 문구")
        view.textAlignment = .center
        view.font = Constants.Font.smallContent
        view.textColor = Constants.Color.background.withAlphaComponent(0.6)
        view.isHidden = true
        view.backgroundColor = .clear
        return view
    }()
    var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.paper
        return view
    }()
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = Constants.Color.paper
        view.delegate = self
        view.dataSource = self
        view.register(SortCardTodoTableViewCell.self, forCellReuseIdentifier: SortCardTodoTableViewCell.reuseIdentifier)
        view.separatorStyle = .none
        view.contentInset = UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0)
        return view
    }()
    var clickButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRealm(date: selectedDate)
        
        clickButton.addTarget(self, action: #selector(goTodo), for: .touchUpInside)
    }
    
    override func configure() {
        view.addSubview(backgroundView)
        [tableView, titleLabel, todoNilLabel].forEach {
            backgroundView.addSubview($0)
        }
        view.addSubview(clickButton)
    }
    
    override func setConstraints() {
        let spacing = 12
        
        clickButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(backgroundView)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(spacing)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leftMargin.equalTo(backgroundView).offset(18)
            make.topMargin.equalTo(backgroundView).offset(22)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(backgroundView).offset(18)
            make.trailing.bottom.equalTo(backgroundView.safeAreaLayoutGuide)
            make.topMargin.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        todoNilLabel.snp.makeConstraints { make in
            make.leading.equalTo(backgroundView.safeAreaLayoutGuide)
            make.trailing.equalTo(backgroundView.safeAreaLayoutGuide)
            make.centerY.equalTo(backgroundView)
        }
    }
    
    @objc func goTodo(sender: UIButton) {
        let vc = WriteViewController()
        vc.selectedDate = self.selectedDate
//        UIApplication.shared.windows.first?.rootViewController = vc
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
//        print(self.nav)
        self.nav.pushViewController(vc, animated: true)

    }
}

extension SortCardTodoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SortCardTodoTableViewCell.reuseIdentifier, for: indexPath) as? SortCardTodoTableViewCell else { return UITableViewCell() }
        
        cell.todoTextView.isEditable = false
        cell.setData(data: todos[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
