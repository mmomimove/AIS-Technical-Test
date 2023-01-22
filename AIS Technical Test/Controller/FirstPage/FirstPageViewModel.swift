//
//  FirstPageViewModel.swift
//  AIS Technical Test
//
//  Created by MmoMiMove on 20/1/2566 BE.
//

import Foundation

protocol FirstPageViewModelDelegate {
    
}

final class FirstPageViewModel {
    
    // MARK: - Parameter
    var delegate: FirstPageViewModelDelegate?

    
    // MARK: - UseCase
//    private lazy var newsDataUC: NewsDataUseCase = .init()
    
    init(delegate: FirstPageViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Function
  
    
}
