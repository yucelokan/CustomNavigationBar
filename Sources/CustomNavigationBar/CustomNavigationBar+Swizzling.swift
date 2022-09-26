//
//  CustomNavigationBar+Swizzling.swift
//  App
//
//  Created by okan.yucel on 2.03.2022.
//  Copyright © 2022 Mobven. All rights reserved.
//

import UIKit

extension UIViewController: UIGestureRecognizerDelegate {
    @objc private dynamic func swizzledViewDidLoad(_ animated: Bool) {
        swizzledViewDidLoad(animated)
        updateNativeNavigationBar()
        (self as? CustomNavigationBarConfigurable)?.updateCustomNavigationBar()
    }
    
    @objc private dynamic func swizzledViewWillAppear(_ animated: Bool) {
        swizzledViewWillAppear(animated)
        updateNativeNavigationBar()
    }
    
    @objc private dynamic func swizzledViewWillDisappear(_ animated: Bool) {
        swizzledViewWillDisappear(animated)
        updateNativeNavigationBar()
    }
    
    private func updateNativeNavigationBar() {
        guard navigationController?.viewControllers.contains(self) ?? false else { return }
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.setNavigationBarHidden(
                self is CustomNavigationBarConfigurable, animated: false
            )
        }
    }
    
    static func setupCustomNavigationBar() {
        swizzleViewDidload()
        swizzleViewWillAppear()
        swizzleViewWillDisappear()
    }
    
    private static func swizzleViewDidload() {
        let selector1 = #selector(UIViewController.viewDidLoad)
        let selector2 = #selector(UIViewController.swizzledViewDidLoad(_:))
        let originalMethod = class_getInstanceMethod(UIViewController.self, selector1)!
        let swizzleMethod = class_getInstanceMethod(UIViewController.self, selector2)!
        method_exchangeImplementations(originalMethod, swizzleMethod)
    }
    
    private static func swizzleViewWillAppear() {
        let selector1 = #selector(UIViewController.viewWillAppear(_:))
        let selector2 = #selector(UIViewController.swizzledViewWillAppear(_:))
        let originalMethod = class_getInstanceMethod(UIViewController.self, selector1)!
        let swizzleMethod = class_getInstanceMethod(UIViewController.self, selector2)!
        method_exchangeImplementations(originalMethod, swizzleMethod)
    }
    
    private static func swizzleViewWillDisappear() {
        let selector1 = #selector(UIViewController.viewWillDisappear(_:))
        let selector2 = #selector(UIViewController.swizzledViewWillDisappear(_:))
        let originalMethod = class_getInstanceMethod(UIViewController.self, selector1)!
        let swizzleMethod = class_getInstanceMethod(UIViewController.self, selector2)!
        method_exchangeImplementations(originalMethod, swizzleMethod)
    }
    
    func clearCustomNavigationBar() {
        
        view.subviews.filter({
            $0.accessibilityIdentifier == CustomNavigationBarView.navigationBarIdentifier
        }).forEach({ view in
            view.removeFromSuperview()
        })
        
        additionalSafeAreaInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        view.setNeedsUpdateConstraints()
        view.updateConstraintsIfNeeded()
    }
}
