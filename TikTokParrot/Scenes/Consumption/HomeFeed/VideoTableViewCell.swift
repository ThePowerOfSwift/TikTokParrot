//
//  VideoTableViewCell.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-21.
//  Copyright © 2019 Mar Koss. All rights reserved.
//

import UIKit
import AVFoundation

enum VideoMenuButton
{
    case profile
    case like
    case message
    case share
}

protocol VideoCellDelegate
{
    func cellPressed(cell: VideoTableViewCell, sender: VideoMenuButton)
}

class VideoTableViewCell: UITableViewCell
{

    @IBOutlet weak var videoContainerView: UIView!
    @IBOutlet weak var playImage: UIImageView!
    
    var player: AVPlayer?
    var videoCellDelegate: VideoCellDelegate?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func profileSelected(_ sender: UIButton)
    {
        videoCellDelegate?.cellPressed(cell: self, sender: .profile)
        print("profile pressed")
    }
    
    @IBAction func likePressed(_ sender: UIButton)
    {
        videoCellDelegate?.cellPressed(cell: self, sender: .like)
        print("like pressed")
    }
    
    @IBAction func messagePressed(_ sender: UIButton)
    {
        videoCellDelegate?.cellPressed(cell: self, sender: .message)
        print("message pressed")
    }
    
    @IBAction func sharePressed(_ sender: UIButton)
    {
        videoCellDelegate?.cellPressed(cell: self, sender: .share)
        print("share pressed")
    }
    
}
