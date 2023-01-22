//
//  ThirdPageViewModel.swift
//  AIS Technical Test
//
//  Created by MmoMiMove on 20/1/2566 BE.
//

import Foundation

protocol ThirdPageViewModelDelegate {
    func setupData()
}

final class ThirdPageViewModel {
    
    // MARK: - Parameter
    var delegate: ThirdPageViewModelDelegate?
    var serviceUrl: String = ""
    var data: Products? = nil
    
    // MARK: - UseCase
    private lazy var getProductDetailUC: GetProductDetailUseCase = .init()
    
    init(delegate: ThirdPageViewModelDelegate,
         serviceUrl: String) {
        self.delegate = delegate
        self.serviceUrl = serviceUrl
    }
    
    // MARK: - Function
    func getProductDetail() {
        getProductDetailUC.execute(.init(url: self.serviceUrl,
                                         completion: { [weak self] detail in
            self?.data = detail
            self?.delegate?.setupData()
        }, error: { error in
            print(error)
        }))
    }
    
}

