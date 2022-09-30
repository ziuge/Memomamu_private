//
//  SortViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/16.
//

import UIKit
import RealmSwift

class SortViewController: UIViewController {
    
    var arrIndexPath = [IndexPath]()
    
    // MARK: Realm
    let repository = Repository()
    var todos: Results<Todo>?
    var diaries: Results<Diary>?
    var content: [Any] = []
    var dates: [String] = []
    
    var emptyLabel: UILabel = {
        let view = UILabel()
        view.text = #"할 일을 추가해주세요\#n;("#
        view.textColor = Constants.Color.text
        view.font = Constants.Font.title
        view.numberOfLines = 2
        view.textAlignment = .center
        return view
    }()
    
    func fetchEverything() {
        todos = repository.fetchEveryTodo().sorted(byKeyPath: "date", ascending: false)
        diaries = repository.fetchEveryDiary().sorted(byKeyPath: "date", ascending: false)
        tableView.reloadData()
    }
    
    var calendarButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "calendar"), for: .normal)
        view.tintColor = Constants.Color.text
        view.configuration?.buttonSize = .large
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = Constants.Color.background
        view.register(SortTableViewCell.self, forCellReuseIdentifier: SortTableViewCell.reuseIdentifier)
        view.separatorStyle = .none
        view.rowHeight = 280
        view.showsVerticalScrollIndicator = false
        view.allowsSelection = false
        return view
    }()
    
    var backgroundShadow: UIView = {
        let view = UIView()
        view.backgroundColor = .magenta
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOffset = CGSize(width: 8, height: 0)
        view.layer.opacity = 0.2
        view.layer.shadowRadius = 5.0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.background
        fetchEverything()
        
        configure()
        setConstraints()
        
        tableView.beginUpdates()
        tableView.setNeedsDisplay()
        tableView.endUpdates()
        
        if diaries?.count == 0 {
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }
        
        calendarButton.addTarget(self, action: #selector(openCalendar), for: .touchUpInside)
    }
    
    func configure() {
        [calendarButton, tableView, emptyLabel].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        calendarButton.snp.makeConstraints { make in
            make.topMargin.equalTo(view.safeAreaLayoutGuide).offset(view.frame.height * 0.067)
            make.trailingMargin.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.width.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.topMargin.equalTo(view.safeAreaLayoutGuide).offset(view.frame.height * 0.12)
            make.trailing.leading.equalTo(view)
            make.bottom.equalTo(view)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.centerY.equalTo(view.safeAreaLayoutGuide).offset(-40)
        }

    }
    
    @objc func openCalendar() {
        let vc = CalendarViewController()
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

    let vc = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    let vc1 = SortCardTodoViewController()
    let vc2 = SortCardDiaryViewController()
    
}

extension SortViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (diaries != nil) ? diaries!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SortTableViewCell.reuseIdentifier, for: indexPath) as? SortTableViewCell else { return UITableViewCell() }
        
        if diaries == nil {
            return UITableViewCell()
        }
        let date = diaries![indexPath.row].date
        cell.selectedDate = date
        cell.setDate(date: date)
        cell.addPageVC(date: date, cell: cell)
        
//        addPageVC(date: diaries![indexPath.row].date, cell: cell)
        
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if arrIndexPath.contains(indexPath) == false {
            cell.alpha = 0
            let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 80, 0)
            cell.layer.transform = transform
            
            UIView.animate(withDuration: 0.5, delay: 0.08 * Double(indexPath.row), usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                cell.alpha = 1
                cell.layer.transform = CATransform3DIdentity
            })
            
            arrIndexPath.append(indexPath)
        }
    }

}
