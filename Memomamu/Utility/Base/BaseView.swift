//
//  BaseView.swift
//  Memomamu
//
//  Created by CHOI on 2022/10/14.
//

import UIKit
import SnapKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure() { }
    func setConstraints() { }
}
