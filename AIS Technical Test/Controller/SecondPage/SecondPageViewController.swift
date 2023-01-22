//
//  SecondPageViewController.swift
//  AIS Technical Test
//
//  Created by MmoMiMove on 20/1/2566 BE.
//

import UIKit

protocol SecondPageViewControllerDelegate {
    func numberOfPage(numberOfPage: Int)
    func pageChangedTo(index: Int)
}

class SecondPageViewController: UIViewController {
    
    // MARK: - New Instance
    class func newInstance() -> SecondPageViewController {
        let viewController = SecondPageViewController(nibName: "SecondPageViewController",
                                                      bundle: nil)
        
        let viewModel = SecondPageViewModel(delegate: viewController)
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControlBanner: UIPageControl!
    @IBOutlet weak var collectionViewBanner: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Parameters
    private var viewModel: SecondPageViewModel?
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel?.getAllProductData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.collectionViewBanner.bringSubviewToFront(self.pageControlBanner)
    }
    
    // MARK: - Function
    func setupView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "SecondPageTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "SecondPageTableViewCell")
        
        self.collectionViewBanner.delegate = self
        self.collectionViewBanner.dataSource = self
        self.collectionViewBanner.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil),
                                           forCellWithReuseIdentifier: "BannerCollectionViewCell")
        
        self.startTimer()
        self.pageControlBanner.addTarget(self, action: #selector(onTapPageControl(_:)), for: .touchUpInside)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshHandler), for: .valueChanged)
        self.scrollView.refreshControl = refreshControl
    }
    
    @objc func pullToRefreshHandler() {
        self.viewModel?.getAllProductData()
    }
    
    func updatePageControlUI() {
        self.pageControlBanner.pageIndicatorTintColor = .gray
        self.pageControlBanner.currentPageIndicatorTintColor = UIColor(named: "AISbaseColor")
    }
    
    @objc func moveToNextPage() {
        let pageWidth: CGFloat = UIScreen.main.bounds.width
        let maxWidth: CGFloat = pageWidth * CGFloat(self.viewModel?.data?.banners.count ?? 0)
        let contentOffset: CGFloat = self.collectionViewBanner.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth {
            slideToX = 0
        }
        
        self.collectionViewBanner.scrollRectToVisible(CGRect(x: slideToX,
                                                             y: 0,
                                                             width: pageWidth,
                                                             height: self.collectionViewBanner.frame.height),
                                                      animated: true)
    }
    
    func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 3,
                                          target: self,
                                          selector: #selector(moveToNextPage),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    // MARK: - Action
    @IBAction func onTapPageControl(_ sender: UIPageControl) {
        let selectedPage = sender.currentPage
        self.updatePageControlUI()
        
        var frame: CGRect = self.collectionViewBanner.frame
        frame.origin.x = frame.size.width * CGFloat(selectedPage)
        frame.origin.y = 0
        self.collectionViewBanner.scrollRectToVisible(frame,
                                                      animated: true)
    }
    
}

extension SecondPageViewController: UITableViewDataSource,
                                    UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel?.data?.products.count == 0 {
            return 0
        } else {
            return self.viewModel?.data?.products.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SecondPageTableViewCell.self), for: indexPath) as? SecondPageTableViewCell {
            cell.selectionStyle = .none
            cell.setData(data: self.viewModel?.data?.products[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ThirdPageViewController.newInstance(serviceUrl: self.viewModel?.data?.products[indexPath.row].product_url ?? "")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}

extension SecondPageViewController: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.data?.banners.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as? BannerCollectionViewCell {
            cell.setData(imgUrl: self.viewModel?.data?.banners[indexPath.row])
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControlBanner.currentPage = indexPath.row
        self.pageChangedTo(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width,
                      height: self.collectionViewBanner.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

    
}

extension SecondPageViewController: SecondPageViewModelDelegate {
    func reloadData() {
        self.scrollView.refreshControl?.endRefreshing()
        
        self.numberOfPage(numberOfPage: self.viewModel?.data?.banners.count ?? 0)
        self.tableView.reloadData()
        self.collectionViewBanner.reloadData()
    }
    
}

extension SecondPageViewController: SecondPageViewControllerDelegate {
    func numberOfPage(numberOfPage: Int) {
        self.pageControlBanner.numberOfPages = numberOfPage
        self.pageControlBanner.currentPage = 0
    }
    
    func pageChangedTo(index: Int) {
        self.updatePageControlUI()
        self.pageControlBanner.currentPage = index
    }
}
