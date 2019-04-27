//
//  HomeFeedViewController.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-20.
//  Copyright (c) 2019 Mar Koss. All rights reserved.
//


import UIKit
import AVFoundation

protocol HomeFeedToBaseDelegate: class
{
    func communicateToBase(sender: VideoMenuButton)
    func saveVideoPosition(row: Int)
}

protocol HomeFeedDisplayLogic: class
{
    func displayVideoStreams()
}

class HomeFeedViewController: UIViewController, HomeFeedDisplayLogic
{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    var interactor: HomeFeedBusinessLogic?
    var router: (NSObjectProtocol & HomeFeedRoutingLogic & HomeFeedDataPassing)?
    
    var playerViewArr = [VideoPlayerView]()
    var currentCell: VideoTableViewCell?
    
    var isVideoPaused = false
    var homeFeedToBaseDelegate: HomeFeedToBaseDelegate?
    
    var isFirstLoad = true
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = HomeFeedInteractor()
        let presenter = HomeFeedPresenter()
        let router = HomeFeedRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        backButton.isHidden = (interactor?.hideBackButton)!

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(videoPressed(sender:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        if currentCell != nil
        {
            currentCell!.player?.pause()
        }
        homeFeedToBaseDelegate?.saveVideoPosition(row: (interactor?.videoIndex)!)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        if currentCell != nil
        {
            currentCell!.player?.play()
        }
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        if isFirstLoad
        {
//            isFirstLoad = false
            let indexPath = IndexPath(row: (interactor?.videoIndex) ?? 0, section: 0)
            tableView.scrollToRow(at: indexPath, at: .none , animated: false)
//            guard let thisCell = tableView.cellForRow(at: indexPath) as? VideoTableViewCell else {return}
//            currentCell = thisCell
//            thisCell.player?.play()
//            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: thisCell.player?.currentItem, queue: .main) { _ in
//                thisCell.player?.seek(to: CMTime.zero)
//                thisCell.player?.play()
//            }
        }
    }
    override func viewDidAppear(_ animated: Bool)
    {
        if isFirstLoad
        {
            isFirstLoad = false
            let indexPath = IndexPath(row: (interactor?.videoIndex) ?? 0, section: 0)
//            tableView.scrollToRow(at: indexPath, at: .middle , animated: false)
            guard let thisCell = tableView.cellForRow(at: indexPath) as? VideoTableViewCell else {return}
            currentCell = thisCell
            thisCell.player?.play()
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: thisCell.player?.currentItem, queue: .main) { _ in
                thisCell.player?.seek(to: CMTime.zero)
                thisCell.player?.play()
            }
        }
    }
    
    // MARK: Display Video Streams
    func displayVideoStreams()
    {
        tableView.reloadData()
    }
    
    // MARK: Functions
    
    @objc func videoPressed(sender: UITapGestureRecognizer)
    {
        guard let currentCell = self.currentCell else {return}
        if !isVideoPaused
        {
            currentCell.player?.pause()
            currentCell.playImage?.isHidden = false
        } else {
            currentCell.player?.play()
            currentCell.playImage.isHidden = true
        }
        isVideoPaused.toggle()
    }
    
    // MARK: Actions
    
    @IBAction func backPressed(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
}

extension HomeFeedViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UIPageViewControllerDelegate, VideoCellDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (interactor?.playerViewArr.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VideoTableViewCell
        if let playerView = interactor?.playerViewArr[indexPath.row]
        {
            cell.videoCellDelegate = self
            cell.videoContainerView.layer.sublayers?.removeAll()
            cell.player = playerView.player
            cell.videoContainerView.layer.addSublayer(playerView.playerLayer)
            playerView.playerLayer.frame = cell.bounds
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        print("HEY")
        print(tableView.visibleCells)
        guard let cell = tableView.visibleCells.first as? VideoTableViewCell else {return}
        if currentCell != nil
        {
            if currentCell != cell
            {
                currentCell!.player?.pause()
                isVideoPaused = false
                currentCell!.playImage?.isHidden = true
                currentCell!.player?.seek(to: CMTime.zero)
                currentCell! = cell
                cell.player?.play()
                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: cell.player?.currentItem, queue: .main) { _ in
                    cell.player?.seek(to: CMTime.zero)
                    cell.player?.play()
                }
            }
            if let indexPath = self.tableView.indexPath(for: currentCell!)
            {
                interactor?.videoIndex = indexPath.row
            }
        }
    }
    
    func cellPressed(cell: VideoTableViewCell, sender: VideoMenuButton)
    {
        switch sender
        {
        case .like:
            return
        default:
            homeFeedToBaseDelegate?.communicateToBase(sender: sender)
        }
    }
}

extension HomeFeedViewController: BaseToHomeFeedDelegate
{
    func loadVideoStreamsIntoFeed(playerViewArr: [VideoPlayerView], row: Int)
    {
        interactor?.playerViewArr = playerViewArr
        tableView.reloadData()
        // TODO: The tableView won't scroll to the saved position
        let ip = IndexPath(row: row, section: 0)
        tableView.scrollToRow(at: ip, at: .top, animated: false)
    }
}
