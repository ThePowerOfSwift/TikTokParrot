//
//  ProfileRouter.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-20.
//  Copyright (c) 2019 Mar Koss. All rights reserved.
//


import UIKit

@objc protocol ProfileRoutingLogic
{
    func routeToHomeFeed(segue: UIStoryboardSegue?)
}

protocol ProfileDataPassing
{
    var dataStore: ProfileDataStore? { get }
}

class ProfileRouter: NSObject, ProfileRoutingLogic, ProfileDataPassing
{
    weak var viewController: ProfileViewController?
    var dataStore: ProfileDataStore?
    
    //     MARK: Routing
    
    func routeToHomeFeed(segue: UIStoryboardSegue?)
    {
        if let segue = segue {
            let destinationVC = segue.destination as! HomeFeedViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToHomeFeed(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "HomeFeedViewController") as! HomeFeedViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToHomeFeed(source: dataStore!, destination: &destinationDS)
            navigateToHomeFeed(source: viewController!, destination: destinationVC)
        }
    }
    
    //     MARK: Navigation
    
    func navigateToHomeFeed(source: ProfileViewController, destination: HomeFeedViewController)
    {
        source.show(destination, sender: nil)
    }
    
    //     MARK: Passing data
    
    func passDataToHomeFeed(source: ProfileDataStore, destination: inout HomeFeedDataStore)
    {
        destination.hideBackButton = false
        destination.playerViewArr = source.playerViewArr
        destination.videoIndex = source.videoIndex
    }
}
