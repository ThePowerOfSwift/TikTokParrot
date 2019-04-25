//
//  VideoPlayerView.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-24.
//  Copyright © 2019 Mar Koss. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView
{
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var urlString: String!
    
    init(urlString: String, frame: CGRect)
    {
        super.init(frame: frame)
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            playerLayer = AVPlayerLayer(player: player)
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
