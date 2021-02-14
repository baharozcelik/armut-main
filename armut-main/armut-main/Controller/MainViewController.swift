//
//  ViewController.swift
//  armut-main
//
//  Created by Bahar on 10.02.2021.
//

import UIKit



class MainViewController: UIViewController {
    
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var serviceCollectionView: UICollectionView!
    
    @IBOutlet weak var otherLabel: UILabel!
    @IBOutlet weak var otherCollectionView: UICollectionView!
    
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postCollectionView: UICollectionView!

    private var viewModel: MainViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    func commonInit() {
        viewModel = MainViewModel(delegate: self)
        
        let serviceNib = UINib(nibName: "ServiceCollectionViewCell", bundle: nil)
        
        // let postNib = UINib(nibName: " POST NIB NAME", bundle: nil)
        
        serviceCollectionView.delegate = self
        serviceCollectionView.dataSource = self
        serviceCollectionView.register(serviceNib, forCellWithReuseIdentifier: "ServiceCollectionViewCell")
        
        otherCollectionView.delegate = self
        otherCollectionView.dataSource = self
        otherCollectionView.register(serviceNib, forCellWithReuseIdentifier: "ServiceCollectionViewCell")
    }
}

extension MainViewController: UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let otherList = viewModel?.getOtherlist(),
              let serviceList = viewModel?.getTrending(),
              let postList = viewModel?.getPosts() else { return 0 }
        
        switch collectionView {
        case serviceCollectionView:
            return serviceList.count
        case otherCollectionView:
            return otherList.count
        case postCollectionView:
            return postList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let otherList = viewModel?.getOtherlist(),
              let serviceList = viewModel?.getTrending(),
              let postList = viewModel?.getPosts() else { return UICollectionViewCell() }
        
        
        switch collectionView {
        case serviceCollectionView:
            let item = serviceList[indexPath.row]
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCollectionViewCell", for: indexPath) as? ServiceCollectionViewCell,
                  let url = item.imageURL,
                  let title = item.name,
                  let proText = item.proCount else { return UICollectionViewCell()}
            
            
            
            cell.setupCell(imageURL: url, title: title, proText: "\(proText)")
            
            return cell
        case otherCollectionView:
            let item = otherList[indexPath.row]
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCollectionViewCell", for: indexPath) as? ServiceCollectionViewCell,
                  let url = item.imageURL,
                  let title = item.name,
                  let proText = item.proCount else { return UICollectionViewCell()}
            
            cell.setupCell(imageURL: url, title: title, proText: "\(proText)")
            return cell
        case postCollectionView:
            return UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
    }
}

extension MainViewController: MainViewModelDelegate {
    func getHomeOnSuccess() {
        serviceCollectionView.reloadData()
        otherCollectionView.reloadData()
        postCollectionView.reloadData()
    }
    
    
}


