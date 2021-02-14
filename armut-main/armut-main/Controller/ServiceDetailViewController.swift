//
//  ServiceDetailViewController.swift
//  armut-main
//
//  Created by Bahar on 14.02.2021.
//

import UIKit
import SDWebImage

class ServiceDetailViewController: UIViewController {
    
    @IBOutlet weak var serviceDetailImageView: UIImageView!
    @IBOutlet weak var serviceDetailLabel: UILabel!
    @IBOutlet weak var serviceDetailProLabel: UILabel!
    @IBOutlet weak var serviceDetailAvarageLabel: UILabel!
    @IBOutlet weak var serviceDetailCompletedJobsLabel: UILabel!
    
    
    var viewModel: ServiceDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func initViews(){
        guard let urlString = viewModel?.getImageUrl(),
              let url = URL(string: urlString) else { return }
        
        serviceDetailImageView.sd_setImage(with: url)
        
        serviceDetailLabel.text = viewModel?.getTitleLabel()

        serviceDetailProLabel.text = "\(viewModel?.getProLabel() ?? "")" + (" pros near you")

        serviceDetailAvarageLabel.text = "\(viewModel?.getAvarageLabel() ?? "")" + (" avarage rating")
        
        serviceDetailCompletedJobsLabel.text = ("Last month ") +  "\(viewModel?.getCompletedJobsLabel() ?? "")" + (" job completed")
        
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension ServiceDetailViewController: ServiceDetailViewModelDelegate {
    func onDetailsOnSuccess() {
        initViews()
    }
}

