//
//  CustomNavigationBarView.swift
//  CustomNavigationBar
//
//  Created by okan.yucel on 25.02.2022.
//

import UIKit

public class CustomNavigationBarView: UIView {
    
    @IBOutlet private var statusBarView: UIView!
    @IBOutlet private var mainStackView: UIStackView!
    @IBOutlet private var statusBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var mainHeightConstraint: NSLayoutConstraint!
    
    private var configuration: CustomNavigationBarConfiguration = .init()
    
    static var navigationBarIdentifier: String {
        return "custom_navigation_bar"
    }

    func configureUI(views: [UIView], configuration: CustomNavigationBarConfiguration) {
        self.configuration = configuration
        accessibilityIdentifier = CustomNavigationBarView.navigationBarIdentifier
        mainStackView.spacing = configuration.spacing

        mainStackView.layoutMargins = configuration.margin
        
        backgroundColor = configuration.backgroundColor
        statusBarView.backgroundColor = configuration.statusBarColor
        
        add(views: views)
        statusBarHeightConstraint.constant = stretchTop
        mainHeightConstraint.constant = additionalSafeAreaInset
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    var stretchTop: CGFloat {
        return UIViewController.statusBarHeight
    }
    
    var extrasFromMargin: CGFloat {
        let extras = configuration.margin.top + configuration.margin.bottom
        return extras
    }
    
    var additionalSafeAreaInset: CGFloat {
        let additionalSafeAreaInset = configuration.height + extrasFromMargin
        return additionalSafeAreaInset
    }
        
    private func add(views: [UIView]) {
        mainStackView.removeAllArrangedSubviews()
        views.forEach { view in
            mainStackView.addArrangedSubview(view)
        }
        
        UIView.performWithoutAnimation { [weak mainStackView] in
            mainStackView?.setNeedsLayout()
            mainStackView?.layoutIfNeeded()
        }
        
    }
    
    var views: [UIView] {
        return mainStackView.arrangedSubviews
    }
    
    var titleLabel: UILabel? {
        return mainStackView.arrangedSubviews.first(
            where: {$0.accessibilityIdentifier == NavigationTitle.navigationTitleID}
        ) as? UILabel
    }
    
    func updateAligments() {
        mainStackView.arrangedSubviews.forEach { view in
            if let navigationButton = view as? NavigationButton {
                navigationButton.updateAligment()
            }
        }
    }
    
}
