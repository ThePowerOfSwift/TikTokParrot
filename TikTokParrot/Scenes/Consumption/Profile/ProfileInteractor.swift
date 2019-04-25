//
//  ProfileInteractor.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-20.
//  Copyright (c) 2019 Mar Koss. All rights reserved.
//


import UIKit

protocol ProfileBusinessLogic
{
    func getThumbnails()
    func getVideoStreams()
    var thumbnailImageArr: [UIImage] { get set }
    var playerViewArr: [VideoPlayerView] { get set }
    var inBaseVC: Bool { get set }
    var videoIndex: Int { get set }
}

protocol ProfileDataStore
{
    var playerViewArr: [VideoPlayerView] { get set }
    var inBaseVC: Bool { get set }
    var videoIndex: Int { get set }
}

class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore
{
    var videoIndex: Int = 0
    
    var presenter: ProfilePresentationLogic?
    var worker: ProfileWorker?
    
    var playerViewArr = [VideoPlayerView]()
    var inBaseVC: Bool = false
    var urlStringArr: [String] = {
        [
            "https://stream.livestreamfails.com/video/5cbde66f38b87.mp4",
            "https://stream.livestreamfails.com/video/5cbdfcb4d3fe8.mp4",
            "https://stream.livestreamfails.com/video/5cbd7358173d7.mp4",
            "https://stream.livestreamfails.com/video/5cbdeaaa15fce.mp4",
            "https://stream.livestreamfails.com/video/5cbe4597b3eab.mp4",
            "https://stream.livestreamfails.com/video/5cbe2889a8222.mp4",
            "https://stream.livestreamfails.com/video/5cbdf622c72f0.mp4",
            "https://stream.livestreamfails.com/video/5cbdb7ca3eeaf.mp4",
            "https://stream.livestreamfails.com/video/5cbdbe585cb00.mp4",
            "https://stream.livestreamfails.com/video/5cbd03144da45.mp4" 
        ]
    }()
    
    var thumbnailImageArr = [UIImage]()
    var thumbnailUrlStringArr: [String] = {
        [
            "https://cdn.livestreamfails.com/thumbnail/5cbde66f0c817.jpg",
            "https://cdn.livestreamfails.com/thumbnail/5cbdfcb489838.jpg",
            "https://cdn.livestreamfails.com/thumbnail/5cbd7357e1ce3.jpg",
            "https://cdn.livestreamfails.com/thumbnail/5cbdeaa9e0ff7.jpg",
            "https://cdn.livestreamfails.com/thumbnail/5cbe459789a3c.jpg",
            "https://cdn.livestreamfails.com/thumbnail/5cbe288984da6.jpg",
            "https://cdn.livestreamfails.com/thumbnail/5cbdf62299dc0.jpg",
            "https://cdn.livestreamfails.com/thumbnail/5cbdb7ca1c472.jpg",
            "https://cdn.livestreamfails.com/thumbnail/5cbdbe5832594.jpg",
            "https://cdn.livestreamfails.com/thumbnail/5cbd03140470e.jpg"
        ]
    }()
    
    // MARK: Get Thumbnails
    func getThumbnails()
    {
        getThumbnailsFromUrls {
            self.presenter?.presentThumbnails()
        }
    }
    
    func getThumbnailsFromUrls(completion:@escaping() -> Void)
    {
        let group = DispatchGroup()
        for urlString in thumbnailUrlStringArr
        {
            group.enter()
            let session = URLSession.shared
            
            let url = URL(string: urlString)
            
            let task = session.dataTask(with: url!) { (data, response, error) in
                if error != nil
                {
                    print(error.debugDescription)
                    group.leave()
                    return
                }
                if (response as? HTTPURLResponse) != nil
                {
                    if let imageData = data
                    {
                        guard let image = UIImage(data: imageData) else
                        {
                            print("Image file is currupted")
                            group.leave()
                            return
                        }
                        self.thumbnailImageArr.append(image)
                        group.leave()
                        return
                    }
                } else {
                    print("No response from server")
                    group.leave()
                }
            }
            task.resume()
        }
        
        group.notify(queue: DispatchQueue.global(qos: .background)) {
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    // MARK: Get Video Streams
    
    func getVideoStreams()
    {
        let videoStreamWorker = VideoStreamWorker()
        videoStreamWorker.getVideoStreams(videoUrlStringArr: urlStringArr) { playerViewArr in
            self.playerViewArr = playerViewArr
            //            self.presenter?.presentVideoStreams()
        }
    }
}

