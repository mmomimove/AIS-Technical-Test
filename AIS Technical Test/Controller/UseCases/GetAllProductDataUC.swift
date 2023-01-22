//
//  GetAllProductDataUC.swift
//  AIS Technical Test
//
//  Created by MmoMiMove on 21/1/2566 BE.
//

import Foundation

public struct GetAllProductUseCaseParameter {
    
    let completion: ((MobileDeveloperModel) -> Void)
    let error: ((Error) -> Void)
    
    init(completion: @escaping (MobileDeveloperModel) -> Void,
         error: @escaping (Error) -> Void) {
        self.completion = completion
        self.error = error
    }
    
}

public class GetAllProductUseCase {
    public func execute(_ param: GetAllProductUseCaseParameter) {
        Service.shared.getAllProduct { data in
            param.completion(data)
        } errorHandler: { error in
            param.error(error)
        }
    }
}
