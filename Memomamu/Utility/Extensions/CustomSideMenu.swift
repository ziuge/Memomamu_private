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
        
        self.menuWidth = self.view.frame.width * 0.8
        self.presentationStyle = .viewSlideOutMenuPartialIn
    }
    
}
