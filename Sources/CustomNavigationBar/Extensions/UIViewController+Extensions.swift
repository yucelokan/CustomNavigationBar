//
//  UIViewController+Extensions.swift
//  CustomNavigationBar
//
//  Created by okan.yucel on 1.03.2022.
//

import UIKit

extension UIViewController {
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }
    
    static var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            let safeAreaTop = window?.safeAreaInsets.top
            let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height
            return safeAreaTop ?? statusBarHeight ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
    
}
