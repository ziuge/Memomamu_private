//
//  CalendarViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/16.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    fileprivate weak var calendar: FSCalendar!
    
    func makeCalendar() {
        print(#function)
        let spacing = 28
        let calendar = FSCalendar(frame: CGRect(x: spacing, y: Int(self.view.frame.height * 0.23), width: Int(self.view.frame.width) - (spacing * 2), height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        self.calendar = calendar
        
        calendar.calendarHeaderView.backgroundColor = .clear
        calendar.calendarWeekdayView.backgroundColor = .clear
        calendar.appearance.eventSelectionColor = UIColor.white
        calendar.appearance.headerDateFormat = "M월"
        calendar.appearance.headerTitleColor = Constants.Color.text
        calendar.appearance.headerTitleAlignment = .center
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.titleDefaultColor = .white
        calendar.appearance.titleWeekendColor = .white
        calendar.appearance.weekdayTextColor = .white
        calendar.appearance.selectionColor = Constants.Color.text
        calendar.appearance.todayColor = Constants.Color.paper.withAlphaComponent(0.4)
        
        calendar.appearance.eventOffset = CGPoint(x: 0, y: -7)
//        calendar.today = nil // Hide the today circle
        calendar.register(CalendarCell.self, forCellReuseIdentifier: "cell")
//        calendar.clipsToBounds = true // Remove top/bottom line
        
        calendar.swipeToChooseGesture.isEnabled = false // Swipe-To-Choose
        
        calendar.scope = .month
        calendar.locale = Locale(identifier: "ko_KR")
        
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
    
    var dateLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.Color.text
        view.text = "17, April"
        view.font = Constants.Font.head
        return view
    }()
    
    override func viewDidLoad() {
        print(#function, self)
        super.viewDidLoad()
        
        makeCalendar()
        
        let dates = [
//            self.gregorian.date(byAdding: .day, value: -1, to: Date()),
            Date(),
//            self.gregorian.date(byAdding: .day, value: 1, to: Date())
        ]
        dates.forEach { (date) in
            self.calendar.select(date, scrollToDate: false)
        }
        self.calendar.accessibilityIdentifier = "calendar"
        
        viewButton.addTarget(self, action: #selector(openWrite), for: .touchUpInside)
        
        configureUI()
        setConstraints()
        addPageVC()
        setPageConstraints()
    }
    
    func configureUI() {
        view.backgroundColor = Constants.Color.background
        [viewButton, dateLabel].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        viewButton.snp.makeConstraints { make in
            make.topMargin.equalTo(view.safeAreaLayoutGuide).offset(view.frame.height * 0.077)
            make.trailingMargin.equalTo(view.safeAreaLayoutGuide).offset(-25)
            make.height.width.equalTo(21)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(view).offset(view.frame.height * 0.12)
            make.centerX.equalTo(view)
        }
    }
    
    let vc = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    func addPageVC() {
        vc.vc1 = CardTodoViewController()
        vc.vc2 = CardDiaryViewController()
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
extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(formatter.string(from: date), "selected!")
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
    
}
