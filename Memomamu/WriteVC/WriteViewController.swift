//
//  WriteViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/08.
//

import UIKit
import SnapKit

class WriteViewController: UIViewController {
    
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
    
    var containerView: UIView = {
        let view = UIView()
        return view
    }()

    let vc = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.background
        configure()
        setConstraints()
        addPageVC()
        
        viewButton.addTarget(self, action: #selector(openCalendar), for: .touchUpInside)

    }
    
    func configure() {
        [containerView, viewButton, dateLabel].forEach {
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
        
        containerView.snp.makeConstraints { make in
            make.topMargin.equalTo(view).offset(view.frame.height * 0.23)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view).multipliedBy(0.63)
        }
    }
    
    func addPageVC() {
        addChild(vc)
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
        setPageConstraints()
    }
    
    func setPageConstraints() {
        vc.view.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(containerView)
//            make.topMargin.equalTo(view).offset(view.frame.height * 0.23)
//            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
//            make.height.equalTo(view).multipliedBy(0.63)
        }
    }
    
    @objc func openCalendar() {
        let vc = CalendarViewController()
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}

