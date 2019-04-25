//
//  HomeFeedInteractor.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-20.
//  Copyright (c) 2019 Mar Koss. All rights reserved.
//


import UIKit

protocol HomeFeedBusinessLogic
{
    func getVideoStreams()
    var urlStringArr: [String] { get set }
    var hideBackButton: Bool { get set }
    var playerViewArr: [VideoPlayerView] { get set }
    var videoIndex: Int { get set }
}

protocol HomeFeedDataStore
{
    var hideBackButton: Bool { get set }
    var playerViewArr: [VideoPlayerView] { get set }
    var videoIndex: Int { get set }
}

class HomeFeedInteractor: HomeFeedBusinessLogic, HomeFeedDataStore
{
    var videoIndex: Int = 0
    var presenter: HomeFeedPresentationLogic?
    
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
        for index in 0...6
        {
            let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            let videoPlayerView = VideoPlayerView(urlString: urlStringArr[index], frame: frame)
            playerViewArr.append(videoPlayerView)
        }
        presenter?.presentVideoStreams()
    }
}
