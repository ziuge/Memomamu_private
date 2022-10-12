//
//  CalendarCell.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/16.
//

import Foundation

import UIKit
import FSCalendar

enum SelectionType : Int {
    case none
    case single
    case leftBorder
    case middle
    case rightBorder
}

class CalendarCell: FSCalendarCell {
    
    weak var circleImageView: UIImageView!
    weak var selectionLayer: CAShapeLayer!
    
    var selectionType: SelectionType = .none {
        didSet {
            setNeedsLayout()
        }
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        let circleImageView = UIImageView(image: UIImage(named: "circle")!)
//        self.contentView.insertSubview(circleImageView, at: 0)
//        self.circleImageView = circleImageView
        
        let selectionLayer = CAShapeLayer()
        selectionLayer.fillColor = UIColor.black.cgColor
        selectionLayer.actions = ["hidden": NSNull()]
        self.contentView.layer.insertSublayer(selectionLayer, below: self.titleLabel!.layer)
        self.selectionLayer = selectionLayer
        
//        self.shapeLayer.isHidden = true
        
        let view = UIView(frame: self.bounds)
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.12)
        self.backgroundView = view;
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.circleImageView.frame = self.contentView.bounds
//        self.backgroundView?.frame = self.bounds.insetBy(dx: 1, dy: 1)
//        self.selectionLayer.frame = self.contentView.bounds
//        
//        if selectionType == .middle {
//            self.selectionLayer.path = UIBezierPath(rect: self.selectionLayer.bounds).cgPath
//        }
//        else if selectionType == .leftBorder {
//            self.selectionLayer.path = UIBezierPath(roundedRect: self.selectionLayer.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: self.selectionLayer.frame.width / 2, height: self.selectionLayer.frame.width / 2)).cgPath
//        }
//        else if selectionType == .rightBorder {
//            self.selectionLayer.path = UIBezierPath(roundedRect: self.selectionLayer.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: self.selectionLayer.frame.width / 2, height: self.selectionLayer.frame.width / 2)).cgPath
//        }
//        else if selectionType == .single {
//            let diameter: CGFloat = min(self.selectionLayer.frame.height, self.selectionLayer.frame.width)
//            self.selectionLayer.path = UIBezierPath(ovalIn: CGRect(x: self.contentView.frame.width / 2 - diameter / 2, y: self.contentView.frame.height / 2 - diameter / 2, width: diameter, height: diameter)).cgPath
//        }

        let titleHeight: CGFloat = self.bounds.size.height * 4 / 5
        var diameter: CGFloat = min(self.bounds.size.height * 5 / 8, self.bounds.size.width)
        diameter = diameter > FSCalendarStandardCellDiameter ? (diameter - (diameter-FSCalendarStandardCellDiameter) * 0.5) : diameter
        shapeLayer.frame = CGRect(x: (bounds.size.width - diameter) / 2,
                                  y: (titleHeight - diameter) / 2,
                                  width: diameter - 2, height: diameter - 2)
        
        let path = UIBezierPath(roundedRect: shapeLayer.bounds, cornerRadius: shapeLayer.bounds.width * 0.5 * appearance.borderRadius).cgPath
        if shapeLayer.path != path {
            shapeLayer.path = path
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        // Override the build-in appearance configuration
        if self.isPlaceholder {
            self.eventIndicator.isHidden = true
            self.titleLabel.textColor = UIColor.lightGray
        }
    }
    
}
