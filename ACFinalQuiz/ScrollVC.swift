//
//  ScrollVC.swift
//  ACFinalQuiz
//
//  Created by YenShao on 2017/4/28.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class ScrollVC: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var myImage:UIImage?
    
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = myImage
        {
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            self.scrollView.addSubview(imageView)
        }
        
    }

    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return imageView
    }

}
