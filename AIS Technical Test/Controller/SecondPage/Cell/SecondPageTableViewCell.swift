//
//  SecondPageTableViewCell.swift
//  AIS Technical Test
//
//  Created by MmoMiMove on 20/1/2566 BE.
//

import UIKit
import AlamofireImage

class SecondPageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgView.contentMode = .scaleToFill
        self.imgView.backgroundColor = .clear
        self.imgView.clipsToBounds = true
    }
    
    func setData(data: Products?) {
        self.lblTitle.text = data?.product_name
        self.lblDescription.text = data?.product_topic
        
        if let imageURL = URL.init(string: data?.product_image ?? "") {
            self.imgView.af_setImage(withURL: imageURL)
        }
    }
    
}
