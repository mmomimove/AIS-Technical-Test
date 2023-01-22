//
//  ViewController.swift
//  AIS Technical Test
//
//  Created by MmoMiMove on 20/1/2566 BE.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5,
                                      execute: {
            // check ว่า token ที่ถูกสร้างจากการ sign in with Facebook หมดอายุรึยัง
            if let token = AccessToken.current,
               !token.isExpired {
                let vc = SecondPageViewController.newInstance()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            } else {
                let vc = FirstPageViewController.newInstance()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        })
        
    }


}

