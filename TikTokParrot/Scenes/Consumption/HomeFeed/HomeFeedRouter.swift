//
//  HomeFeedRouter.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-24.
//  Copyright (c) 2019 Mar Koss. All rights reserved.
//


import UIKit

@objc protocol HomeFeedRoutingLogic
{
}

protocol HomeFeedDataPassing
{
    var dataStore: HomeFeedDataStore? { get }
}

class HomeFeedRouter: NSObject, HomeFeedRoutingLogic, HomeFeedDataPassing
{
    weak var viewController: HomeFeedViewController?
    var dataStore: HomeFeedDataStore?
    
}
