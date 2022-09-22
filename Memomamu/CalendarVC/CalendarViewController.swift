//
//  CalendarViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/16.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: UIViewController {
    
    // MARK: Realm
    let repository = Repository()
    var todos: Results<Todo>?
    var diaries: Results<Diary>?
    
    func fetchEverything() {
        todos = repository.fetchEveryTodo()
        diaries = repository.fetchEveryDiary()
    }
    
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate weak var calendar: FSCalendar!
    
    func makeCalendar() {
        print(#function)
        let spacing = 36
        let calendar = FSCalendar(frame: CGRect(x: spacing, y: Int(self.view.frame.height * 0.12), width: Int(self.view.frame.width) - (spacing * 2), height: Int(self.view.frame.height * 0.4)))
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        self.calendar = calendar
        
        calendar.calendarHeaderView.backgroundColor = .clear
        calendar.calendarWeekdayView.backgroundColor = .clear
        calendar.appearance.eventSelectionColor = UIColor.white
        calendar.appearance.headerDateFormat = "MMMM"
        calendar.appearance.headerTitleColor = Constants.Color.text
        calendar.appearance.headerTitleAlignment = .center
        calendar.appearance.headerTitleFont = Constants.Font.head
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.headerHeight = 60
        calendar.appearance.headerTitleOffset = CGPoint(x: 0, y: -12)
        
        calendar.appearance.titleDefaultColor = .white
        calendar.appearance.titleWeekendColor = .white
        calendar.appearance.weekdayTextColor = Constants.Color.text
        calendar.appearance.weekdayFont = Constants.Font.content
        calendar.appearance.selectionColor = Constants.Color.text
        
        calendar.appearance.todayColor = Constants.Color.paper.withAlphaComponent(0.4)
        calendar.appearance.caseOptions = FSCalendarCaseOptions.weekdayUsesSingleUpperCase
        calendar.appearance.titleFont = Constants.Font.content
        
        calendar.register(CalendarCell.self, forCellReuseIdentifier: "cell")
//        calendar.clipsToBounds = true // Remove top/bottom line
        
        calendar.swipeToChooseGesture.isEnabled = false // Swipe-To-Choose
        
        calendar.scope = .month
        
        calendar.scrollEnabled = true
        calendar.scrollDirection = .horizontal
        calendar.placeholderType = .none
    }
    var viewButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "todayButton.jpg"), for: .normal)
        view.tintColor = Constants.Color.text
        return view
    }()
//    var dateLabel: UILabel = {
//        let view = UILabel()
//        view.textColor = Constants.Color.text
//        view.text = "September"
//        view.font = Constants.Font.head
//        return view
//    }()
    
    override func viewDidLoad() {
        print(#function, self)
        super.viewDidLoad()
        
        fetchEverything()
        makeCalendar()

        self.calendar.select(Date(), scrollToDate: false)
        self.calendar.accessibilityIdentifier = "calendar"
        
        viewButton.addTarget(self, action: #selector(openWrite), for: .touchUpInside)
        
        configureUI()
        setConstraints()
        addPageVC()
        setPageConstraints()
    }
    
    func configureUI() {
        view.backgroundColor = Constants.Color.background
        [viewButton].forEach {
            view.addSubview($0)
        }
    }
    func setConstraints() {
        viewButton.snp.makeConstraints { make in
            make.topMargin.equalTo(view.safeAreaLayoutGuide).offset(view.frame.height * 0.077)
            make.trailingMargin.equalTo(view.safeAreaLayoutGuide).offset(-25)
            make.height.width.equalTo(21)
        }
        
//        dateLabel.snp.makeConstraints { make in
//            make.topMargin.equalTo(view).offset(view.frame.height * 0.12)
//            make.topMargin.equalTo(view.safeAreaLayoutGuide).offset(view.frame.height * 0.077)
//            make.centerX.equalTo(view)
//        }
    }
//
//    func setData(date: Date) {
//        let selectedDate = DateFormatter.dateOnly.string(from: date)
//        var todos: Results<Todo>! = repository.fetchTodo(date: selectedDate)
//        var diary: Diary? = repository.fetchDiary(date: selectedDate)
//    }
    
    let vc = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    let vc1 = CardTodoViewController()
    let vc2 = CardDiaryViewController()
    
    func addPageVC() {
        vc.vc1 = vc1
        vc.vc2 = vc2
        addChild(vc)
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
        setPageConstraints()
    }
    func setPageConstraints() {
        vc.view.snp.makeConstraints { make in
            make.topMargin.equalTo(calendar.snp.bottom).offset(24)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottomMargin.equalTo(view.safeAreaLayoutGuide).offset(-36)
        }
    }
    
    @objc func openWrite() {
        let vc = WriteViewController()
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

// MARK: - CalendarVC Delegate, DataSource
extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let date = DateFormatter.dateOnly.string(from: date)
        addPageVC()
        
        vc.createPageViewController(vc1: vc1, vc2: vc2)
        vc.configurePageViewController()
        vc1.selectedDate = date
        vc1.fetchRealm()
        vc2.selectedDate = date
        vc2.fetchRealm()
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let selectedDate = DateFormatter.dateOnly.string(from: date)
        var nums = 0
        if todos!.filter("date == %@", selectedDate).count != 0 {
            nums += 1
        }
        if diaries!.filter("date == %@", selectedDate).count != 0 {
            nums += 1
        }
        
        return nums
    }

    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        let selectedDate = DateFormatter.dateOnly.string(from: date)
        var colors: [UIColor] = []
        if todos!.filter("date == %@", selectedDate).count != 0 {
            colors.append(Constants.Color.text)
        }
        if diaries!.filter("date == %@", selectedDate).count != 0 {
            colors.append(Constants.Color.point)
        }
        return colors
    }

    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
        let selectedDate = DateFormatter.dateOnly.string(from: date)
        var colors: [UIColor] = []
        if todos!.filter("date == %@", selectedDate).count != 0 {
            colors.append(Constants.Color.text)
        }
        if diaries!.filter("date == %@", selectedDate).count != 0 {
            colors.append(Constants.Color.point)
        }
        return colors
    }
    
//    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
//        let eventScaleFactor: CGFloat = 1.0
//        cell.eventIndicator.transform = CGAffineTransform(scaleX: eventScaleFactor, y: eventScaleFactor)
//    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventOffsetFor date: Date) -> CGPoint {
        return CGPoint(x: 0, y: 2)
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        let eventScaleFactor: CGFloat = 1
        cell.eventIndicator.transform = CGAffineTransform(scaleX: eventScaleFactor, y: eventScaleFactor)
        cell.eventIndicator.layer.cornerRadius = 0
    }
    
}
