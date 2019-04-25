//
//  BasePresenter.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-23.
//  Copyright (c) 2019 Mar Koss. All rights reserved.
//

import UIKit

protocol BasePresentationLogic
{
    func presentVideoStreams()
}

class BasePresenter: BasePresentationLogic
{
    weak var viewController: BaseDisplayLogic?
        
    // MARK: Present Video Streams
    
    func presentVideoStreams()
    {
        viewController?.displayVideoStreams()
    }
}
