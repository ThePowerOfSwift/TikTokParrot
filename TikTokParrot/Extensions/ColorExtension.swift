//
//  ColorExtension.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-21.
//  Copyright © 2019 Mar Koss. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
