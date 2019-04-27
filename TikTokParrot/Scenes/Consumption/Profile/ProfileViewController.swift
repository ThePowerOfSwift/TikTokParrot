//
//  ProfileViewController.swift
//  TikTokParrot
//
//  Created by Mar Koss on 2019-04-20.
//  Copyright (c) 2019 Mar Koss. All rights reserved.
//


import UIKit

protocol ProfileDisplayLogic: class
{
    func displayThumbnails()
}

class ProfileViewController: UICollectionViewController, ProfileDisplayLogic
{
    
    @IBOutlet weak var videoCollection: UICollectionView!
    
    
    var interactor: ProfileBusinessLogic?
    var router: (NSObjectProtocol & ProfileRoutingLogic & ProfileDataPassing)?
    
    var userInfoCellId = "userInfoCell"
    var userVideoCellId = "videoCell"
    var homeFeedSegueId = "HomeFeed"
    
    override var prefersStatusBarHidden: Bool {
        return false
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
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
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
        let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
        
        interactor?.getThumbnails()
        interactor?.getVideoStreams()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        if interactor?.inBaseVC == true
        {
            navigationController?.navigationBar.isHidden = true
        } else {
            navigationController?.navigationBar.isHidden = false
        }

    }
    
    // MARK: Display Thumbnails
    func displayThumbnails()
    {
        collectionView.reloadData()
    }
}

extension ProfileViewController: BaseToProfileDelegate
{
    func setupProfile(profileIsInBaseVC: Bool)
    {
        interactor?.inBaseVC = profileIsInBaseVC
    }
    
    
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout
{
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if section == 1
        {
            return interactor?.thumbnailImageArr.count ?? 0
        }
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if indexPath.section == 0
        {
            let userInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: userInfoCellId, for: indexPath) as! UserInfoCollectionViewCell
            return userInfoCell
        }
        
        let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: userVideoCellId, for: indexPath) as! UserVideoCollectionViewCell
        videoCell.imageView.image = interactor?.thumbnailImageArr[indexPath.row] ?? UIImage(named: "add")
        
        return videoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1
        {
            let width: CGFloat = (collectionView.frame.size.width / 3) - 1
            return CGSize(width: width, height: 120)
        }
        return CGSize(width: collectionView.frame.width, height: view.frame.height/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        if section == 0
        {
            return CGSize(width: 0, height: 0)
        }
        
        return CGSize(width: collectionView.frame.width, height: 50)
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {

        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if indexPath.section == 1
        {
            interactor?.videoIndex = indexPath.row
            performSegue(withIdentifier: homeFeedSegueId, sender: self)
        }
    }
}
