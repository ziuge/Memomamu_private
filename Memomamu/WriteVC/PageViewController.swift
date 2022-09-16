//
//  PageViewController.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/10.
//

import UIKit
import RealmSwift

class PageViewController: UIPageViewController {
    
    var pageViewControllerList: [UIViewController] = []
    
    var vc1: UIViewController = TodoViewController()
    var vc2: UIViewController = DiaryViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPageViewController()
        configurePageViewController()
    }
    
    func createPageViewController() {
//        let vc1 = TodoViewController()
//        let vc2 = DiaryViewController()
        pageViewControllerList = [self.vc1, self.vc2]
    }
    
    func configurePageViewController() {
        delegate = self
        dataSource = self
        
        guard let first = pageViewControllerList.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
        
    }

}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        
        return previousIndex < 0 ? nil : pageViewControllerList[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        
        return nextIndex >= pageViewControllerList.count ? nil : pageViewControllerList[nextIndex]
    }

}
