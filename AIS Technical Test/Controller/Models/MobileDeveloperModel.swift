//
//  MobileDveloperModel.swift
//  AIS Technical Test
//
//  Created by MmoMiMove on 20/1/2566 BE.
//

import Foundation
import SwiftyJSON

class MobileDeveloperModel {
    var banners: [String] = []
    var products: [Products] = []
    
    init(json: JSON) {
        self.banners = json["banners"].arrayValue.map({ $0.stringValue })
        self.products = json["products"].arrayValue.map({ Products(json: $0) })
    }
    
}

class Products {
    
    var product_name : String = ""
    var product_topic : String = ""
    var product_image : String = ""
    var product_url : String = ""
    var product_detail: String = ""
    
    init(json: JSON) {
        self.product_name = json["product_name"].stringValue
        self.product_topic = json["product_topic"].stringValue
        self.product_image = json["product_image"].stringValue
        self.product_url = json["product_url"].stringValue
        self.product_detail = json["product_detail"].stringValue
    }
    
}
