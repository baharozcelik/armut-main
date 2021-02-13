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

    var trending: [Service] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkingManager.getHomeList(onSuccess: { home in
            guard let trending = home?.trending else { return}
            self.trending = trending
            self.commonInit()
        }, onError: {
            
        })

    }
    
    func commonInit() {
        serviceCollectionView.delegate = self
        serviceCollectionView.dataSource = self
        let nib = UINib(nibName: "ServiceCollectionViewCell", bundle: nil)
        serviceCollectionView.register(nib, forCellWithReuseIdentifier: "ServiceCollectionViewCell")
    }
}

extension MainViewController: UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trending.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = trending[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCollectionViewCell", for: indexPath) as? ServiceCollectionViewCell,
              let url = item.imageURL,
              let title = item.name,
              let proText = item.proCount else { return UICollectionViewCell()}
        
        
        
        cell.setupCell(imageURL: url, title: title, proText: "\(proText)")
        
        return cell
        
    }
    
    
}

