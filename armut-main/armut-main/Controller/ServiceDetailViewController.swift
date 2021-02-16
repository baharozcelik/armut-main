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
    
    @IBOutlet weak var instructionView1: UIView!
    @IBOutlet weak var instructionView2: UIView!
    @IBOutlet weak var instructionView3: UIView!
    
    
    var viewModel: ServiceDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        instructionView1.layer.cornerRadius = 30
        instructionView1.layer.borderWidth = 1
        instructionView1.layer.borderColor = UIColor.gray.cgColor
        
        instructionView2.layer.cornerRadius = 30
        instructionView2.layer.borderWidth = 1
        instructionView2.layer.borderColor = UIColor.gray.cgColor
        
        instructionView3.layer.cornerRadius = 30
        instructionView3.layer.borderWidth = 1
        instructionView3.layer.borderColor = UIColor.gray.cgColor
        
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
    func getDetailsOnError() {
        var errorMessage = UIAlertController(title: "Error", message: "Unkown error. Can you try this again?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.navigationController?.popViewController(animated: true)
         })
        //Add OK button to a dialog message
        errorMessage.addAction(ok)
        // Present Alert to
        self.present(errorMessage, animated: true, completion: nil)
    }
    
    func onDetailsOnSuccess() {
        initViews()
    }
}

