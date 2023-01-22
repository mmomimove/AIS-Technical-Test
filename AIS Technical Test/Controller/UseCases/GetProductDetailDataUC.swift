//
//  GetProductDetailDataUC.swift
//  AIS Technical Test
//
//  Created by MmoMiMove on 21/1/2566 BE.
//

import Foundation

public struct GetProductDetailUseCaseParameter {
    
    let url: String
    let completion: ((Products) -> Void)
    let error: ((Error) -> Void)
    
    init(url: String,
         completion: @escaping (Products) -> Void,
         error: @escaping (Error) -> Void) {
        self.url = url
        self.completion = completion
        self.error = error
    }
    
}

public class GetProductDetailUseCase {
    public func execute(_ param: GetProductDetailUseCaseParameter) {
        Service.shared.getProductDetail(url: param.url) { data in
            param.completion(data)
        } errorHandler: { error in
            param.error(error)
        }
    }
}
