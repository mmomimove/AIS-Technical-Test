//
//  FirstPageViewController.swift
//  AIS Technical Test
//
//  Created by MmoMiMove on 20/1/2566 BE.
//

import UIKit
import FBSDKLoginKit
import AuthenticationServices

class FirstPageViewController: UIViewController {
    
    // MARK: - New Instance
    class func newInstance() -> FirstPageViewController {
        let viewController = FirstPageViewController(nibName: "FirstPageViewController",
                                         bundle: nil)
        
        let viewModel = FirstPageViewModel(delegate: viewController)
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var viewFacebookLogIn: UIView!
    @IBOutlet weak var imgViewFacebookLogIn: UIImageView!
    @IBOutlet weak var viewAppleLogIn: UIView!
    @IBOutlet weak var imgViewAppleLogIn: UIImageView!
    @IBOutlet weak var btnFacebookLogIn: UIButton!
    
    
    
    // MARK: - Parameters
    private var viewModel: FirstPageViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.performExistingAccountSetupFlows()
    }
    
    // MARK: - Function
    func setupView() {
        self.viewFacebookLogIn.layer.cornerRadius = 10
        self.viewFacebookLogIn.clipsToBounds = true
        self.viewAppleLogIn.layer.cornerRadius = 10
        self.viewAppleLogIn.clipsToBounds = true
        
    }
    
    func performExistingAccountSetupFlows() {
        if #available(iOS 13.0, *) {
            let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                            ASAuthorizationPasswordProvider().createRequest()]
            let authorizationController = ASAuthorizationController(authorizationRequests: requests)
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        } else {
            // Fallback on earlier versions
        }
    }
    
    func logInWithFacebook() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile"], from: self) { result, error in
            if let error = error {
                print("Encountered Erorr: \(error)")
            } else if let result = result, result.isCancelled {
                print("Cancelled")
            } else {
                print("Logged In")
                let vc = SecondPageViewController.newInstance()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }
    }
    
    // ฟังก์ชันนี้ยังไม่สามารถใช้งานจริงได้ เนื่องจาก account ที่ใช้ไม่ใช่ developer account(ต้องเสียเงิน)
    func logInWithApple() {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        } else {
            // Fallback on earlier versions
        }
    }

    // MARK: - Action
    @IBAction func onTapFacebookLogin(_ sender: UIButton) {
        self.logInWithFacebook()
    }
    
    @IBAction func onTapAppleLogIn(_ sender: UIButton) {
        self.logInWithApple()
    }
}

extension FirstPageViewController: FirstPageViewModelDelegate {
    
}

extension FirstPageViewController: ASAuthorizationControllerDelegate , ASAuthorizationControllerPresentationContextProviding {
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
//            let userIdentifier = appleIDCredential.user
//            let fullName = appleIDCredential.fullName
//            let email = appleIDCredential.email
            
            let vc = SecondPageViewController.newInstance()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        
        case let passwordCredential as ASPasswordCredential:
        
            DispatchQueue.main.async {
                let vc = SecondPageViewController.newInstance()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
            
        default:
            break
        }
    }
    
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
