//
//  WalkThroughVC.swift
//  WelcomeInterface
//
//  Created by 贝蒂小熊 on 2022/1/21.
//

import UIKit

class WalkThroughVC: UIViewController {
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var skipButton: UIButton!
    
    //实现跳过按钮
    @IBAction func skipButtonTapped(sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "已展示过开始推送界面")
        dismiss(animated: true, completion: nil)
    }
    
    var walkThroughPageViewController: WalkThroughPageVC?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? WalkThroughPageVC {
            walkThroughPageViewController = pageViewController
            walkThroughPageViewController?.walkThroughDelegate = self
        }
    }
    
    //实现下一页按钮
    @IBAction func nextButtonTapped(sender: UIButton) {
        if let index = walkThroughPageViewController?.currentIndex {
            switch index {
            case 0...1:
                walkThroughPageViewController?.forwardPage()
            case 2:
                //存储开始推送界面的状态
                UserDefaults.standard.set(true, forKey: "已展示过开始推送界面")
                dismiss(animated: true, completion: nil)
            default: break
            }
        }
        
        updateUI()
    }
    
    //1判断跳过按钮是否该被隐藏 2通过currntPgae属性的设定来更改页面控制的指示器
    func updateUI() {
        if let index = walkThroughPageViewController?.currentIndex {
            switch index {
            case 0...1:
                nextButton.setTitle("下一页", for: .normal)
                skipButton.isHidden = false
            case 2:
                nextButton.setTitle("开始", for: .normal)
                skipButton.isHidden = true
            default: break
            }
            
            pageControl.currentPage = index
        }
    }
    
    
}

extension WalkThroughVC: WalkThroughPageViewControllerDeleagte {
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
}
