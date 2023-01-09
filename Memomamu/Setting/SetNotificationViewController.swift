//
//  SetNotificationViewController.swift
//  Memomamu
//
//  Created by CHOI on 2023/01/08.
//

import UIKit

class SetNotificationViewController: BaseViewController {
    
    // MARK: UI
    var logoImageView: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "Frame"), for: .normal)
        view.setImage(UIImage(named: "Frame"), for: .highlighted)
        return view
    }()
    var titleLabel: UILabel = {
        let view = UILabel()
        view.text = ":) 알림 설정"
        view.textColor = Constants.Color.text
        view.font = Constants.Font.content
        return view
    }()
    
    var stack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        view.distribution = .equalSpacing
        return view
    }()
    
    var switchStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.spacing = 8
        view.layoutMargins = UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: 16)
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }()
    var onButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "switchOn"), for: .normal)
        view.setTitle("on", for: .normal)
        return view
    }()
    var offButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "switchOff"), for: .normal)
        view.setTitle("off", for: .normal)
        return view
    }()
    
    var lineImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "SettingLine")
        return view
    }()
    
    var setTimeStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.layoutMargins = UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: 16)
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }()
    var setTimeLabel: UILabel = {
        let view = UILabel()
        view.text = "시간 설정"
        view.textColor = Constants.Color.text
        view.font = Constants.Font.content
        return view
    }()
    var setTimePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.datePickerMode = .time
        
        return view
    }()
    
    var setEventStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.layoutMargins = UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: 16)
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }()
    var eventLabel: UILabel = {
        let view = UILabel()
        view.text = "이벤트 알림 수신"
        view.textColor = Constants.Color.text
        view.font = Constants.Font.content
        return view
    }()
    
    var eventButtonStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 6
        return view
    }()
    var acceptButton: UIButton = {
        let view = UIButton()
        view.setTitle(" 받기 ", for: .normal)
        view.backgroundColor = Constants.Color.text
        view.setTitleColor(Constants.Color.paper, for: .normal)
        view.titleLabel?.font = Constants.Font.smallButton
        return view
    }()
    var declineButton: UIButton = {
        let view = UIButton()
        view.setTitle(" 받지않기 ", for: .normal)
        view.backgroundColor = Constants.Color.text
        view.setTitleColor(Constants.Color.paper, for: .normal)
        view.titleLabel?.font = Constants.Font.smallButton
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func configure() {
        [logoImageView, titleLabel, stack].forEach {
            view.addSubview($0)
        }
        [switchStack, lineImage, setTimeStack, setEventStack].forEach {
            stack.addArrangedSubview($0)
        }
        [onButton, offButton].forEach {
            switchStack.addArrangedSubview($0)
        }
        [setTimeLabel, setTimePicker].forEach {
            setTimeStack.addArrangedSubview($0)
        }
        [eventLabel, eventButtonStack].forEach {
            setEventStack.addArrangedSubview($0)
        }
        [acceptButton, declineButton].forEach {
            eventButtonStack.addArrangedSubview($0)
        }
        
    }
    override func setConstraints() {
        let spacing = 16
        
        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(84.7)
            make.height.equalTo(49)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.equalTo(view).offset(spacing * 2)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(spacing * 2)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(spacing * 2)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-(spacing * 2))
            make.height.equalTo(30)
        }
        stack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(spacing)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(53)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-53)
        }
        switchStack.snp.makeConstraints { make in
            make.width.equalTo(120)
        }
        onButton.snp.makeConstraints { make in
            
        }
        offButton.snp.makeConstraints { make in
            
        }
        lineImage.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        setTimeStack.snp.makeConstraints { make in
            
        }
        setTimeLabel.snp.makeConstraints { make in
            
        }
        setTimePicker.snp.makeConstraints { make in
            
        }
        setEventStack.snp.makeConstraints { make in
            
        }
        eventLabel.snp.makeConstraints { make in
            
        }
        eventButtonStack.snp.makeConstraints { make in
            
        }
        acceptButton.snp.makeConstraints { make in
            
        }
        declineButton.snp.makeConstraints { make in
            
        }
        
    }
    
}
