//
//  ViewController.swift
//  armut-main
//
//  Created by Bahar on 10.02.2021.
//

import UIKit
import SafariServices


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
    
    private func commonInit() {
        viewModel = MainViewModel(delegate: self)
        
        let serviceNib = UINib(nibName: "ServiceCollectionViewCell", bundle: nil)
        
        let postNib = UINib(nibName: "PostCollectionViewCell", bundle: nil)
        
        // let postNib = UINib(nibName: " POST NIB NAME", bundle: nil)
        
        serviceCollectionView.delegate = self
        serviceCollectionView.dataSource = self
        serviceCollectionView.register(serviceNib, forCellWithReuseIdentifier: "ServiceCollectionViewCell")
        
        otherCollectionView.delegate = self
        otherCollectionView.dataSource = self
        otherCollectionView.register(serviceNib, forCellWithReuseIdentifier: "ServiceCollectionViewCell")
        
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        postCollectionView.register(postNib, forCellWithReuseIdentifier: "PostCollectionViewCell")
        
    }
    
    private func openSafariPage(urlString: String?){
        guard let urlString = urlString,
              let url = URL(string: urlString) else { return }
        let safariViewController = SFSafariViewController(url: url)
        self.present(safariViewController, animated: true, completion: nil)
    }
    
    private func openDetailsScreen(serviceId: String?){
        guard let serviceId = serviceId else { return }
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        
        guard let detailsViewController = storyBoard.instantiateViewController(withIdentifier: "ServiceDetailViewController") as? ServiceDetailViewController
        else { return }
        
        detailsViewController.viewModel = ServiceDetailViewModel(delegate: detailsViewController, serviceId: serviceId)
        self.navigationController?.pushViewController(detailsViewController, animated: true)
        
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
            let item = postList[indexPath.row]
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as? PostCollectionViewCell,
                  let url = item.imageURL,
                  let title = item.title,
                  let categoryText = item.category else { return UICollectionViewCell()}
            
            cell.setupCell(imageURL: url, title: title, categoryText: categoryText)
            return cell
        case postCollectionView:
            return UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let otherList = viewModel?.getOtherlist(),
              let serviceList = viewModel?.getTrending(),
              let postList = viewModel?.getPosts() else { return }
        
        switch collectionView {
        case serviceCollectionView:
            let item = serviceList[indexPath.row]
            openDetailsScreen(serviceId: "\(item.id ?? 0)")
        case otherCollectionView:
            let item = otherList[indexPath.row]
            openDetailsScreen(serviceId: "\(item.id ?? 0)")
        case postCollectionView:
            let item = postList[indexPath.row]
            openSafariPage(urlString: item.link)
        default:
            return
        }
    }
}

extension MainViewController: MainViewModelDelegate {
    func getHomeListOnError() {
        // Create new Alert
        var errorMessage = UIAlertController(title: "Error", message: "Unkown error. Can you try this again?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.viewModel?.getHomeList()
         })
        //Add OK button to a dialog message
        errorMessage.addAction(ok)
        // Present Alert to
        self.present(errorMessage, animated: true, completion: nil)
        
    }
    
    func getHomeOnSuccess() {
        serviceCollectionView.reloadData()
        otherCollectionView.reloadData()
        postCollectionView.reloadData()
    }
    
    
}


