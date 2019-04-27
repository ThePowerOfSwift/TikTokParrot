//
//  ViewControllerTest.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-20.
//  Copyright © 2019 Mar Koss. All rights reserved.
//

import UIKit

protocol BaseToHomeFeedDelegate: class
{
    func loadVideoStreamsIntoFeed(playerViewArr: [VideoPlayerView], row: Int)
}

protocol BaseToProfileDelegate: class
{
    func setupProfile(profileIsInBaseVC: Bool)
}

protocol BaseDisplayLogic: class
{
    func displayVideoStreams()
}

class BaseViewController: UIViewController, BaseDisplayLogic
{
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var menuBar: UICollectionView!
    
    var interactor: BaseBusinessLogic?
    var router: (NSObjectProtocol & BaseRoutingLogic & BaseDataPassing)?


    let imageNames = ["home", "search", "add", "chat", "user"]
    var childVC: ChildViewControllerEnum = .Home
    var currentChildVC: UIViewController?
    var baseToHomeFeedDelegate: BaseToHomeFeedDelegate?
    var baseToProfileDelegate: BaseToProfileDelegate?
    
    var selectedMenuItem = 0
    
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
        let interactor = BaseInteractor()
        let presenter = BasePresenter()
        let router = BaseRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        menuBar.delegate = self
        menuBar.dataSource = self
        menuBar.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
        interactor?.getVideoStreams()
//        automaticallyAdjustsScrollViewInsets = false
//        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Get / Display Video Streams
    func displayVideoStreams()
    {
        configureChildViewController(childVC: .Home)
    }
    
    func configureChildViewController(childVC: ChildViewControllerEnum)
    {
        if let currentChild = currentChildVC
        {
            currentChild.willMove(toParent: nil)
            currentChild.removeFromParent()
            currentChild.view.removeFromSuperview()
            if type(of: currentChild) == HomeFeedViewController.self
            {
                let child = currentChild as! HomeFeedViewController
                if let currentCell = child.currentCell
                {
                    currentCell.player?.pause()
                }
            }
        }
        
        let storyboard = UIStoryboard.init(name: childVC.rawValue, bundle: nil)
//        var childViewCon = UIViewController()
        switch childVC
        {
        case .Home:
            let child = storyboard.instantiateViewController(withIdentifier: "HomeFeedViewController") as! HomeFeedViewController
            child.homeFeedToBaseDelegate = self
            addChildViewController(childViewCon: child)
            baseToHomeFeedDelegate = child
            baseToHomeFeedDelegate?.loadVideoStreamsIntoFeed(playerViewArr: (interactor?.playerViewArr)!, row: (interactor?.videoIndex)!)
        case .Search:
            let child = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
            addChildViewController(childViewCon: child)
        case .Notifications:
            let child = storyboard.instantiateViewController(withIdentifier: "NotificationsViewController") as! NotificationsViewController
            addChildViewController(childViewCon: child)
        case .Profile:
            let child = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            addChildViewController(childViewCon: child)
            baseToProfileDelegate = child
            baseToProfileDelegate?.setupProfile(profileIsInBaseVC: true)
        }
    }
    
    private func addChildViewController(childViewCon: UIViewController)
    {
        self.containerView.addSubview(childViewCon.view)
        self.addChild(childViewCon)
        childViewCon.didMove(toParent: self)
        self.currentChildVC = childViewCon
        childViewCon.view.translatesAutoresizingMaskIntoConstraints = false
        childViewCon.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        childViewCon.view.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        childViewCon.view.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        childViewCon.view.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
    }
    
    // MARK: Actions
    
    @IBAction func addVideoPressed(_ sender: UIButton)
    {
        performSegue(withIdentifier: "Record", sender: self)
    }
}

extension BaseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! MenuCell
        cell.setupViews()
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        if indexPath.row == 2
        {
            cell.isUserInteractionEnabled = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width / 5, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        var childVC: ChildViewControllerEnum?
        switch indexPath.row
        {
        case 0:
            childVC = .Home
        case 1:
            childVC = .Search
        case 3:
            childVC = .Notifications
        case 4:
            childVC = .Profile
        default:
            print("")
        }
        guard let child = childVC else {return}
        selectedMenuItem = indexPath.row
        configureChildViewController(childVC: child)
    }
}

extension BaseViewController: HomeFeedToBaseDelegate
{
    func saveVideoPosition(row: Int)
    {
        interactor?.videoIndex = row
    }
    
    func communicateToBase(sender: VideoMenuButton)
    {
        switch sender {
        case .profile:
            performSegue(withIdentifier: "Profile", sender: self)
        default:
            return
        }
    }
}

enum ChildViewControllerEnum: String
{
    case Home = "HomeFeed"
    case Search = "Search"
    case Notifications = "Notifications"
    case Profile = "Profile"
}






