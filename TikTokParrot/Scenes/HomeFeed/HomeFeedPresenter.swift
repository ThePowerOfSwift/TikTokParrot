//
//  HomeFeedPresenter.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-20.
//  Copyright (c) 2019 Mar Koss. All rights reserved.
//


import UIKit

protocol HomeFeedPresentationLogic
{
    func presentVideoStreams()
}

class HomeFeedPresenter: HomeFeedPresentationLogic
{
    weak var viewController: HomeFeedDisplayLogic?
    
    // MARK: Present Video Streams
    
    func presentVideoStreams()
    {
        viewController?.displayVideoStreams()
    }
}
