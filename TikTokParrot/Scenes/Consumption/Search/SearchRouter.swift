//
//  SearchRouter.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-20.
//  Copyright (c) 2019 Mar Koss. All rights reserved.
//


import UIKit

@objc protocol SearchRoutingLogic
{
}

protocol SearchDataPassing
{
    var dataStore: SearchDataStore? { get }
}

class SearchRouter: NSObject, SearchRoutingLogic, SearchDataPassing
{
    weak var viewController: SearchViewController?
    var dataStore: SearchDataStore?

}
