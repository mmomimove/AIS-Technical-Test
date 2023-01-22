//
//  Service.swift
//  AIS Technical Test
//
//  Created by MmoMiMove on 20/1/2566 BE.
//

import Foundation
import Alamofire
import SwiftyJSON

class Service {
    
    static let shared: Service = Service()
    var headers: HTTPHeaders {
        return ["Content-Type": "application/json"]
    }
        
    func getAllProduct(completionHandler: @escaping (MobileDeveloperModel) -> Void,
                       errorHandler: @escaping (Error) -> Void) {
        
        let url = ServiceURLs.GET_ALL_PRODUCT_DATA
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: headers).responseJSON { responseData in
            DispatchQueue.main.async {
                switch responseData.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = MobileDeveloperModel.init(json: json)
                    completionHandler(data)
                case .failure(let error):
                    errorHandler(error)
                }
            }
        }
        
    }
    
    func getProductDetail(url: String,
                          completionHandler: @escaping (Products) -> Void,
                          errorHandler: @escaping (Error) -> Void) {
        AF.request(url,
                   method: .post,
                   parameters: nil,
                   headers: headers).responseJSON { responseData in
            DispatchQueue.main.async {
                switch responseData.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = Products.init(json: json)
                    completionHandler(data)
                case .failure(let error):
                    errorHandler(error)
                }
            }
        }
    }
    
}
