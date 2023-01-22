//
//  ThirdPageViewController.swift
//  AIS Technical Test
//
//  Created by MmoMiMove on 20/1/2566 BE.
//

import UIKit
import AlamofireImage

class ThirdPageViewController: UIViewController {

    // MARK: - New Instance
    class func newInstance(serviceUrl: String) -> ThirdPageViewController {
        let viewController = ThirdPageViewController(nibName: "ThirdPageViewController",
                                         bundle: nil)
        
        let viewModel = ThirdPageViewModel(delegate: viewController,
                                           serviceUrl: serviceUrl)
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    
    // MARK: - Parameters
    private var viewModel: ThirdPageViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.viewModel?.getProductDetail()
    }
    
    // MARK: - Function
    func setupView() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshHandler), for: .valueChanged)
        self.scrollView.refreshControl = refreshControl
    }
    
    @objc func pullToRefreshHandler() {
        self.viewModel?.getProductDetail()
    }

    // MARK: - Action
    @IBAction func onTapBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

extension ThirdPageViewController: ThirdPageViewModelDelegate {
    func setupData() {
        self.scrollView.refreshControl?.endRefreshing()
        self.lblTitle.text = self.viewModel?.data?.product_name
        self.lblDescription.text = self.viewModel?.data?.product_detail
        
        if let imageURL = URL.init(string: self.viewModel?.data?.product_image ?? "") {
            self.imgView.af_setImage(withURL: imageURL)
        }
    }
}
