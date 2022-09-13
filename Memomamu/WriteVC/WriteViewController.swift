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

    let vc = PageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.background
        
        configure()
        setConstraints()
        addPageVC()
    }
    
    func configure() {
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
    
    func addPageVC() {
        addChild(vc)
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
        setPageConstraints()
    }
    
    func setPageConstraints() {
        vc.view.snp.makeConstraints { make in
            make.topMargin.equalTo(view).offset(view.frame.height * 0.23)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view).multipliedBy(0.63)
        }
    }
    
}


