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
        
        calendar.appearance.eventOffset = CGPoint(x: 0, y: -7)
//        calendar.today = nil // Hide the today circle
        calendar.register(CalendarCell.self, forCellReuseIdentifier: "cell")
//        calendar.clipsToBounds = true // Remove top/bottom line
        
        calendar.swipeToChooseGesture.isEnabled = false // Swipe-To-Choose
        
//        let scopeGesture = UIPanGestureRecognizer(target: calendar, action: #selector(calendar.handleScopeGesture(_:)));
//        calendar.addGestureRecognizer(scopeGesture)
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
        
        self.title = "FSCalendar"
        // Uncomment this to perform an 'initial-week-scope'
        // self.calendar.scope = FSCalendarScopeWeek;
        
        let dates = [
            self.gregorian.date(byAdding: .day, value: -1, to: Date()),
            Date(),
            self.gregorian.date(byAdding: .day, value: 1, to: Date())
        ]
        dates.forEach { (date) in
            self.calendar.select(date, scrollToDate: false)
        }
        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"
        
        
        configureUI()
        setConstraints()
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
    
    
    
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date, "selected!")
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
    
    
    
//
//    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
//        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
//        return cell
//    }
//
//    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
//        self.configure(cell: cell, for: date, at: position)
//    }
//
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        if self.gregorian.isDateInToday(date) {
//            return "今"
//        }
//        return nil
//    }
//
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        return 2
//    }
//
//    // MARK:- FSCalendarDelegate
//
//    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
//        self.calendar.frame.size.height = bounds.height
//        self.eventLabel.frame.origin.y = calendar.frame.maxY + 10
//    }
//
//    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {
//        return monthPosition == .current
//    }
//
//    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
//        return monthPosition == .current
//    }
//
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        print("did select date \(self.formatter.string(from: date))")
//        self.configureVisibleCells()
//    }
//
//    func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
//        print("did deselect date \(self.formatter.string(from: date))")
//        self.configureVisibleCells()
//    }
//
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
//        if self.gregorian.isDateInToday(date) {
//            return [UIColor.orange]
//        }
//        return [appearance.eventDefaultColor]
//    }
//
////    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
////        calendar.snp.updateConstraints { (make) in
////            make.height.equalTo(bounds.height)
////
////        }
////        self.view.layoutIfNeeded()
////    }
//
//    // MARK: - Private functions
//
//    private func configureVisibleCells() {
//        calendar.visibleCells().forEach { (cell) in
//            let date = calendar.date(for: cell)
//            let position = calendar.monthPosition(for: cell)
//            self.configure(cell: cell, for: date!, at: position)
//        }
//    }
//
//    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
//
//        let diyCell = (cell as! CalendarCell)
//        // Custom today circle
//        diyCell.circleImageView.isHidden = !self.gregorian.isDateInToday(date)
//        // Configure selection layer
//        if position == .current {
//
//            var selectionType = SelectionType.none
//
//            if calendar.selectedDates.contains(date) {
//                let previousDate = self.gregorian.date(byAdding: .day, value: -1, to: date)!
//                let nextDate = self.gregorian.date(byAdding: .day, value: 1, to: date)!
//                if calendar.selectedDates.contains(date) {
//                    if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(nextDate) {
//                        selectionType = .middle
//                    }
//                    else if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(date) {
//                        selectionType = .rightBorder
//                    }
//                    else if calendar.selectedDates.contains(nextDate) {
//                        selectionType = .leftBorder
//                    }
//                    else {
//                        selectionType = .single
//                    }
//                }
//            }
//            else {
//                selectionType = .none
//            }
//            if selectionType == .none {
//                diyCell.selectionLayer.isHidden = true
//                return
//            }
//            diyCell.selectionLayer.isHidden = false
//            diyCell.selectionType = selectionType
//
//        } else {
//            diyCell.circleImageView.isHidden = true
//            diyCell.selectionLayer.isHidden = true
//        }
//    }
    
}
