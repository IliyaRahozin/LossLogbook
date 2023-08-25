//
//  SplashScreenViewController.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 23.08.2023.
//

import UIKit

protocol SplashScreenViewControllerDelegate: AnyObject {
    func splashScreenAnimationDidFinish()
}

class SplashScreenViewController: UIViewController {
        
    private lazy var logoImageView: UIImageView = {
        let iv = UIImageView(image: Constant.Images.SplashScreenLogo)
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    weak var delegate: SplashScreenViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(logoImageView)
        logoImageView.center(inView: view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.logoImageView.transform = .identity
            self?.delegate?.splashScreenAnimationDidFinish()
        }
    }
    
}
