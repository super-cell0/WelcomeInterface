//
//  WalkThroughContentVC.swift
//  WelcomeInterface
//
//  Created by 贝蒂小熊 on 2022/1/21.
//

import UIKit

class WalkThroughContentVC: UIViewController {
    
    @IBOutlet weak var headingLabel: UILabel! {
        didSet {
            headingLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var subHeadingLabel: UILabel! {
        didSet {
            subHeadingLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var contentImageView: UIImageView!
    
    var index = 0 //页面索引值
    var heading = ""
    var subHeading = ""
    var imageFile = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headingLabel.text = heading
        subHeadingLabel.text = subHeading
        contentImageView.image = UIImage(named: imageFile)

    }
    


}
