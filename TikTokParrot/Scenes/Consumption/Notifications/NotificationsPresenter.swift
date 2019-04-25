//
//  NotificationsPresenter.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-20.
//  Copyright (c) 2019 Mar Koss. All rights reserved.
//


import UIKit

protocol NotificationsPresentationLogic
{
    func presentSomething(response: Notifications.Something.Response)
}

class NotificationsPresenter: NotificationsPresentationLogic
{
    weak var viewController: NotificationsDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: Notifications.Something.Response)
    {
        let viewModel = Notifications.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
