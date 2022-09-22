//
//  CardTodoViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/16.
//

import UIKit
import RealmSwift

class CardTodoViewController: UIViewController {
    
    var selectedDate = DateFormatter.dateOnly.string(from: Date())
    
    // MARK: Realm
    let repository = Repository()
    var todos: Results<Todo>! {
        didSet {
            tableView.reloadData()
        }
    }
    var diary: Diary? = nil
    
    func fetchRealm() {
        todos = repository.fetchTodo(date: selectedDate)
        tableView.reloadData()
        if todos.count == 0 {
            todoNilLabel.isHidden = false
            tableView.isHidden = true
        } else {
            todoNilLabel.isHidden = true
            tableView.isHidden = false
        }
    }
    
    var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "to do list"
        view.font = Constants.Font.cardTitle
        view.textColor = Constants.Color.background
        return view
    }()
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = Constants.Color.paper
        view.delegate = self
        view.dataSource = self
        view.register(CardTodoTableVIewCell.self, forCellReuseIdentifier: CardTodoTableVIewCell.reuseIdentifier)
        view.separatorStyle = .none
        return view
    }()
    var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.paper
        return view
    }()
    var todoNilLabel: UILabel = {
        let view = UILabel()
        view.text = "할 일을 작성하세요 :)"
        view.font = Constants.Font.content
        view.textColor = Constants.Color.background.withAlphaComponent(0.6)
        view.isHidden = true
        view.backgroundColor = .clear
        return view
    }()
    var clickButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRealm()
        
        configure()
        setConstraints()
        clickButton.addTarget(self, action: #selector(goTodo), for: .touchUpInside)
    }
    
    func configure() {
        view.addSubview(backgroundView)
        [tableView, titleLabel, todoNilLabel].forEach {
            backgroundView.addSubview($0)
        }
        view.addSubview(clickButton)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    func setConstraints() {
        let spacing = 40
        
        clickButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(backgroundView)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.width.equalTo(Int(view.frame.width) - spacing)
            make.leftMargin.equalTo(spacing)
//            make.height.equalTo(view.frame.height * 0.28)
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.topMargin.equalTo(backgroundView).offset(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(backgroundView).offset(30)
            make.trailing.bottom.equalTo(backgroundView.safeAreaLayoutGuide).offset(-24)
            make.topMargin.equalTo(titleLabel.snp.bottom).offset(26)
//            make.bottom.equalTo(backgroundView).offset(300)
        }
        
        todoNilLabel.snp.makeConstraints { make in
            make.leading.equalTo(backgroundView).offset(36)
            make.trailing.equalTo(backgroundView.safeAreaLayoutGuide)
//            make.topMargin.equalTo(titleLabel.snp.bottom).offset(40)
            make.centerY.equalTo(backgroundView)
        }
    }

    @objc func goTodo() {
        let vc = WriteViewController()
        vc.selectedDate = self.selectedDate
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

extension CardTodoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardTodoTableVIewCell.reuseIdentifier, for: indexPath) as? CardTodoTableVIewCell else { return UITableViewCell() }
        cell.todoTextView.isEditable = false
        cell.setData(data: todos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
