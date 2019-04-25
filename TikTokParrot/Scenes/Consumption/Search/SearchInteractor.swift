//
//  SearchInteractor.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-20.
//  Copyright (c) 2019 Mar Koss. All rights reserved.
//


import UIKit

protocol SearchBusinessLogic
{
}

protocol SearchDataStore
{
    //var name: String { get set }
}

class SearchInteractor: SearchBusinessLogic, SearchDataStore
{
    var presenter: SearchPresentationLogic?
    var worker: SearchWorker?
}
