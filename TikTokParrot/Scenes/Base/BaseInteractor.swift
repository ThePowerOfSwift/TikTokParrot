//
//  BaseInteractor.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-23.
//  Copyright (c) 2019 Mar Koss. All rights reserved.


import UIKit

protocol BaseBusinessLogic
{
    func getVideoStreams()
    var playerViewArr: [VideoPlayerView] { get set }
    var videoIndex: Int { get set }
}

protocol BaseDataStore
{
    var videoIndex: Int { get set }
}

class BaseInteractor: BaseBusinessLogic, BaseDataStore
{
    
    var presenter: BasePresentationLogic?
    var videoIndex: Int = 0
    
    var hideBackButton: Bool = true
    
    var playerViewArr = [VideoPlayerView]()
    
    var urlStringArr: [String] = {
        [
            "https://stream.livestreamfails.com/video/5cb8e91685e1b.mp4",
            "https://stream.livestreamfails.com/video/5cb8a8a5570b6.mp4",
            "https://stream.livestreamfails.com/video/5cbca9cc69772.mp4",
            "https://stream.livestreamfails.com/video/5cbd056e01969.mp4",
            "https://stream.livestreamfails.com/video/5cbb70aa34e26.mp4",
            "https://stream.livestreamfails.com/video/5cbbadd488cf8.mp4",
            "https://stream.livestreamfails.com/video/5cba0fb337850.mp4"
        ]
    }()
    
    // MARK: Get Video Streams
    func getVideoStreams()
    {
        let videoStreamWorker = VideoStreamWorker()
        videoStreamWorker.getVideoStreams(videoUrlStringArr: urlStringArr) { playerViewArr in
            self.playerViewArr = playerViewArr
            self.presenter?.presentVideoStreams()
        }
    }
}
