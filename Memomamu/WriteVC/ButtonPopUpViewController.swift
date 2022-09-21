//
//  ButtonPopUpViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/21.
//

import Foundation
import UIKit

class ButtonPopUpViewController: UIViewController {
    
    let finishedButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = Constants.Color.background.withAlphaComponent(0.7)
        view.setTitleColor(Constants.Color.paper, for: .normal)
        view.setTitle("완료", for: .normal)
        return view
    }()
    let delayedButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = Constants.Color.background.withAlphaComponent(0.7)
        view.setTitleColor(Constants.Color.paper, for: .normal)
        view.setTitle("연기", for: .normal)
        return view
    }()
    let unfinishedButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = Constants.Color.background.withAlphaComponent(0.7)
        view.setTitleColor(Constants.Color.paper, for: .normal)
        view.setTitle("미완료", for: .normal)
        return view
    }()
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.paper
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func configure() {
        view.addSubview(containerView)
        [finishedButton, delayedButton, unfinishedButton].forEach {
            containerView.addSubview($0)
        }
    }
    
    func setConstraints() {
        containerView.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(160)
            
        }
        
        finishedButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(40)
//            make.top.leading.equalTo(self.safeAreaLayoutGuide)
        }
        
        delayedButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(40)
//            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(finishedButton.snp.trailing).offset(8)
        }
        
        unfinishedButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(54)
//            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(delayedButton.snp.trailing).offset(8)
        }
    }
}
