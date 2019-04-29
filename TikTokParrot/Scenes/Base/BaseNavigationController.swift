//
//  BaseNavigationController.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-26.
//  Copyright © 2019 Mar Koss. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController
{

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
//        automaticallyAdjustsScrollViewInsets = false
//        setNeedsStatusBarAppearanceUpdate()
    }
    


}
