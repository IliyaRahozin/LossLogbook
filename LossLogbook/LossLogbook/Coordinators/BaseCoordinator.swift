//
//  AppCoordinator.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 23.08.2023.
//

import UIKit

protocol BaseCoordinatorFlow {
    func showDetail(data: Any?)
}

protocol SplashScreenCoordinatorDelegate: AnyObject {
    func splashScreenCoordinatorDidFinishAnimation()
}

class BaseCoordinator: Coordinator {
    // MARK: - PROPERTIES
    var navigationController: UINavigationController = UINavigationController()

    func start() {
        showSplashScreen()
    }
    
    // MARK: - COORDINATION
    func showSplashScreen() {
        let splashScrennViewController = SplashScreenViewController()
        splashScrennViewController.delegate = self
        navigationController.viewControllers = [splashScrennViewController]
    }

    private func showMainAppFlow() {
        let initialViewController = ViewController()
        initialViewController.coordinator = self
        navigationController.setViewControllers([initialViewController], animated: true)
    }
}

// MARK: - SplashPresenterDelegate
extension BaseCoordinator: SplashScreenViewControllerDelegate {
    func splashScreenAnimationDidFinish() {
        showMainAppFlow()
    }
}

// MARK: - BaseCoordinatorFlow
extension BaseCoordinator: BaseCoordinatorFlow {
    func showDetail(data: Any?) {
        // TODO: - Detail data coordination
        // go to detail info
    }
}
