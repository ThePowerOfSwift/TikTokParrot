//
//  NotificationsInteractor.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-20.
//  Copyright (c) 2019 Mar Koss. All rights reserved.
//


import UIKit

protocol NotificationsBusinessLogic
{
    func doSomething(request: Notifications.Something.Request)
}

protocol NotificationsDataStore
{
    //var name: String { get set }
}

class NotificationsInteractor: NotificationsBusinessLogic, NotificationsDataStore
{
    var presenter: NotificationsPresentationLogic?
    var worker: NotificationsWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: Notifications.Something.Request)
    {
        worker = NotificationsWorker()
        worker?.doSomeWork()
        
        let response = Notifications.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
