//
//  SecondPageViewModel.swift
//  AIS Technical Test
//
//  Created by MmoMiMove on 20/1/2566 BE.
//

import Foundation

protocol SecondPageViewModelDelegate {
    func reloadData()
}

final class SecondPageViewModel {
    
    // MARK: - Parameter
    var delegate: SecondPageViewModelDelegate?
    var data: MobileDeveloperModel? = nil
    
    // MARK: - UseCase
    private lazy var getAllProductUC: GetAllProductUseCase = .init()
    
    init(delegate: SecondPageViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Function
    func getAllProductData() {
        getAllProductUC.execute(.init(completion: { [weak self] allProducts in
            self?.data = allProducts
            self?.delegate?.reloadData()
        }, error: { error in
            print(error)
        }))
    }
    
}

