//
//  BaseRouter.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-24.
//  Copyright (c) 2019 Mar Koss. All rights reserved.
//


import UIKit

@objc protocol BaseRoutingLogic
{
}

protocol BaseDataPassing
{
    var dataStore: BaseDataStore? { get }
}

class BaseRouter: NSObject, BaseRoutingLogic, BaseDataPassing
{
    weak var viewController: BaseViewController?
    var dataStore: BaseDataStore?
    
}
