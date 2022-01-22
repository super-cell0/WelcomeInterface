//
//  ViewController.swift
//  WelcomeInterface
//
//  Created by 贝蒂小熊 on 2022/1/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Thread.sleep(forTimeInterval: 1.5)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //判断是否需要展示开始推送界面
        if UserDefaults.standard.bool(forKey: "已展示过开始推送界面") {
            return
        }
        
        let storyboard = UIStoryboard(name: "Interface", bundle: nil)
        if let walkThroughViewController = storyboard.instantiateViewController(withIdentifier: "WalkThroughVC") as? WalkThroughVC {
            
            present(walkThroughViewController, animated: true, completion: nil)
        }
    }
    



}

