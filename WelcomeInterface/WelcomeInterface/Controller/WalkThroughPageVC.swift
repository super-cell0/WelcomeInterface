//
//  WalkThroughPageVC.swift
//  WelcomeInterface
//
//  Created by 贝蒂小熊 on 2022/1/21.
//

import UIKit

protocol WalkThroughPageViewControllerDeleagte: AnyObject {
    func didUpdatePageIndex(currentIndex: Int)
}

class WalkThroughPageVC: UIPageViewController {
    
    var pageImages = ["p1", "p2", "p3"]
    var pageHeadings = ["欢迎来到的我的App", "让我们一起来创造吧！", "我是贝蒂小熊"]
    var pageSubHeadings = ["探寻您最喜欢的运用方式并创建您自己的App指南", "探寻您最喜欢的运用方式并创建您自己的App指南", "让我们开始吧"]
    var currentIndex = 0
    
    weak var walkThroughDelegate: WalkThroughPageViewControllerDeleagte?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //资料来源设定为自己
        dataSource = self
        //建立第一个显示页面
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        
        delegate = self
    }
    
    //实现下一页按钮
    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    
}

extension WalkThroughPageVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkThroughContentVC).index
        index -= 1
        
        return contentViewController(at: index) //返回辅助方法
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkThroughContentVC).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    //接收索引参数建立想的页面控制
    func contentViewController(at index: Int) -> WalkThroughContentVC? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        
        //建立新的视图控制器传送资料
        let storyboard = UIStoryboard(name: "Interface", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "WalkThroughContentVC") as? WalkThroughContentVC {
            
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subHeading = pageSubHeadings[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        
        return nil
    }
    
    
    
}

extension WalkThroughPageVC: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewcontroller = pageViewController.viewControllers?.first as? WalkThroughContentVC {
                currentIndex = contentViewcontroller.index
                //通知委派协议
                walkThroughDelegate?.didUpdatePageIndex(currentIndex: contentViewcontroller.index)
            }
        }
    }
}
