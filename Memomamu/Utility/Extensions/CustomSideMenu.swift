//
//  CustomSideMenu.swift
//  Memomamu
//
//  Created by CHOI on 2023/01/08.
//

import UIKit
import SideMenu

class CustomSideMenuNavigationController: SideMenuNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuWidth = self.view.frame.width
//        self.presentationStyle = .viewSlideOutMenuPartialIn
        
        self.presentationStyle = .menuSlideIn
        self.presentationStyle.backgroundColor = .black
        self.presentationStyle.presentingEndAlpha = 0.7
        
    }
    
}
