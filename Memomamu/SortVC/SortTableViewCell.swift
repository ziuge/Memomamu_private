//
//  SortTableViewCell.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/27.
//

import UIKit

class SortTableViewCell: UITableViewCell {
    
    var selectedDate: String = DateFormatter.dateOnly.string(from: Date())
    
    var dateView = SortDateView()
    var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.background
        return view
    }()
    var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Constants.Color.background
        
        configure()
        setConstraints()
        
        addPageVC(date: selectedDate, cell: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stringToDate(string: String) -> Date {
        let selectedDate = string
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd."
        formatter.timeZone = NSTimeZone(name: "KST") as TimeZone?
        formatter.locale = Locale(identifier: "en_US")
        let date = formatter.date(from: selectedDate)!
        return date
    }
    func dateToString(date: Date) -> String {
        let date = date
        let formatter = DateFormatter()
        formatter.dateFormat = #"d, \#nMMM"#
        formatter.timeZone = NSTimeZone(name: "KST") as TimeZone?
        formatter.locale = Locale(identifier: "en_US")
        let string = formatter.string(from: date)
        return string
    }
    
    func setDate(date: String) {
        let rawDate = stringToDate(string: date)
        self.dateView.dateLabel.text = dateToString(date: rawDate)
    }
    
    func configure() {
        [containerView, dateView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        dateView.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(contentView)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.26)
        }

        containerView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.leading.equalTo(dateView.snp.trailing)
            make.trailing.equalTo(contentView)
        }
        
//        bottomView.snp.makeConstraints { make in
//            make.top.leading.bottom.trailing.equalTo(contentView)
//        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    let vc = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    let vc1 = SortCardTodoViewController()
    let vc2 = SortCardDiaryViewController()
    
    func addPageVC(date: String, cell: SortTableViewCell) {
        print(#function, date)
        vc1.selectedDate = date
        vc2.selectedDate = date
        vc.vc1 = vc1
        vc.vc2 = vc2
//        self.contentView.addChild(vc)
        containerView.addSubview(vc.view)
        vc.selectedDate = date
//        vc.didMove(toParent: self)
        vc.view.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(cell.containerView)
        }
        vc1.fetchRealm(date: date)
    }

}
