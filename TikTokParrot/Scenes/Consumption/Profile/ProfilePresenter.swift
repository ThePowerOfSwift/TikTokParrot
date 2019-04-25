//
//  ProfilePresenter.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-20.
//  Copyright (c) 2019 Mar Koss. All rights reserved.
//


import UIKit

protocol ProfilePresentationLogic
{
    func presentThumbnails()
}

class ProfilePresenter: ProfilePresentationLogic
{
    weak var viewController: ProfileDisplayLogic?
    
    // MARK: Present Thumbnails
    
    func presentThumbnails()
    {

        viewController?.displayThumbnails()
    }
}
