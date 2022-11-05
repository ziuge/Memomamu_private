//
//  SortViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/16.
//

import UIKit
import RealmSwift

class SortViewController: BaseViewController {
    
    var arrIndexPath = [IndexPath]()
    
    // MARK: Realm
    let repository = Repository()
    var todos: Results<Todo>?
    var diaries: Results<Diary>?
    var content: [Any] = []
    var dates: [String] = []
    func fetchEverything() {
        todos = repository.fetchEveryTodo().sorted(byKeyPath: "date", ascending: false)
        diaries = repository.fetchEveryDiary().sorted(byKeyPath: "date", ascending: false)
        tableView.reloadData()
    }
    
    // MARK: UI
    var emptyLabel: UILabel = {
        let view = UILabel()
        view.text = NSLocalizedString("EmptySortTable", comment: "Empty SortTableView")
        view.textColor = Constants.Color.text
        view.font = Constants.Font.title
        view.numberOfLines = 2
        view.textAlignment = .center
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
    var calendarButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "calendarButton.jpg"), for: .normal)
        view.tintColor = Constants.Color.text
        view.configuration?.buttonSize = .large
        return view
    }()
    var settingButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "settingButton"), for: .normal)
        view.configuration?.buttonSize = .large
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.background
        fetchEverything()
        
        tableView.beginUpdates()
        tableView.setNeedsDisplay()
        tableView.endUpdates()
        
        if diaries?.count == 0 {
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }
        
        settingButton.addTarget(self, action: #selector(openSetting), for: .touchUpInside)
        calendarButton.addTarget(self, action: #selector(openCalendar), for: .touchUpInside)

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.dismiss(animated: true)
    }
    
    override func configure() {
        [tableView, emptyLabel, calendarButton, settingButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        calendarButton.snp.makeConstraints { make in
            make.topMargin.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailingMargin.equalTo(view.safeAreaLayoutGuide).offset(-26)
            make.height.width.equalTo(40)
        }
        
//        settingButton.snp.makeConstraints { make in
//            make.topMargin.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.leadingMargin.equalTo(view.safeAreaLayoutGuide).offset(26)
//            make.height.width.equalTo(40)
//        }
        
        tableView.snp.makeConstraints { make in

            make.topMargin.equalTo(view.safeAreaLayoutGuide).offset(60)
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
        let nav = UINavigationController(rootViewController: vc)
//        UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: vc)
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
    
    @objc func openSetting() {
        let vc = SettingViewController()
        self.navigationController?.show(vc, sender: self)
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
        cell.vc1.nav = self.navigationController ?? UINavigationController()
        cell.vc2.nav = self.navigationController ?? UINavigationController()
        
//        cell.vc.createPageViewController(vc1: vc1, vc2: vc2)
//        cell.vc.configurePageViewController()
        cell.vc.setViewControllers([cell.vc1], direction: .forward, animated: false)
        
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
