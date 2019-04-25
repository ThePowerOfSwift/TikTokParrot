//
//  VideoStreamWorker.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-23.
//  Copyright (c) 2019 Mar Koss. All rights reserved.
//


import UIKit

class VideoStreamWorker
{
    func getVideoStreams(videoUrlStringArr: [String], completion:@escaping(_ playerViewArr:[VideoPlayerView]) -> Void)
    {
        var playerViewArr = [VideoPlayerView]()
        for videoUrlString in videoUrlStringArr
        {
            let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            let videoPlayerView = VideoPlayerView(urlString: videoUrlString, frame: frame)
            playerViewArr.append(videoPlayerView)
        }
        completion(playerViewArr)
    }
}
