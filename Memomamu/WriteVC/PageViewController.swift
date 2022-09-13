//
//  PageViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/10.
//

import Foundation
import UIKit
import RealmSwift

class PageViewController: UIPageViewController {
    
    var pageViewControllerList: [UIViewController] = []
    
    func createPageViewController() {
        let vc1 = TodoViewController()
        let vc2 = DiaryViewController()
        pageViewControllerList = [vc1, vc2]
    }
    
    func configurePageViewController() {
        delegate = self
        dataSource = self
    }

}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        <#code#>
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        <#code#>
    }
    
    
}
