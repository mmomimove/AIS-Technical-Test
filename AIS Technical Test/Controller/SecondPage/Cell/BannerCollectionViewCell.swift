//
//  BannerCollectionViewCell.swift
//  AIS Technical Test
//
//  Created by MmoMiMove on 21/1/2566 BE.
//

import UIKit
import AlamofireImage

class BannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgView.contentMode = .scaleToFill
        self.imgView.clipsToBounds = true
    }
    
    func setData(imgUrl: String?) {
        if let imageURL = URL.init(string: imgUrl ?? "") {
            
            // ในส่วนการแสดงรูปภาพ Banners จะมี url ที่ดึงมาจาก server บางตัวใช้งานไม่ได้ จึงแสดงผลเป็นรูปสีขาว
            self.imgView.af_setImage(withURL: imageURL)
        }
    }

}
