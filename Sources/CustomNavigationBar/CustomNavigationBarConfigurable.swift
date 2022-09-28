//
//  CustomNavigationBarConfigurable.swift
//  CustomNavigationBar
//
//  Created by okan.yucel on 28.02.2022.
//

import UIKit

public protocol CustomNavigationBarConfigurable: CustomNavigationBarViewConfiguration {
    var customTitle: String? { get set }
    func getCustomNavigationView<T: UIView>(identifier: String) -> T?
    func updateCustomNavigationBar()
    func setCustomNavigationBarHidden(_ status: Bool, animated: Bool)
}

public extension CustomNavigationBarConfigurable where Self: UIViewController {
    var navigationTitleLabel: UILabel? {
        (view.subviews.first(
            where: { $0.accessibilityIdentifier == CustomNavigationBarView.navigationBarIdentifier }
        ) as? CustomNavigationBarView)?.titleLabel
    }

    var customTitle: String? {
        get {
            let customNavigationBarView = view.subviews.first(
                where: { $0.accessibilityIdentifier == CustomNavigationBarView.navigationBarIdentifier }
            ) as? CustomNavigationBarView
            return customNavigationBarView?.titleLabel?.text
        }
        set {
            let customNavigationBarView = view.subviews.first(
                where: { $0.accessibilityIdentifier == CustomNavigationBarView.navigationBarIdentifier }
            ) as? CustomNavigationBarView
            customNavigationBarView?.titleLabel?.text = newValue
        }
    }

    func getCustomNavigationView<T: UIView>(identifier: String) -> T? {
        let customNavigationBarView = view.subviews.first(
            where: { $0.accessibilityIdentifier == CustomNavigationBarView.navigationBarIdentifier }
        ) as? CustomNavigationBarView

        return customNavigationBarView?.views.first(
            where: { $0.accessibilityIdentifier == identifier }
        ) as? T
    }

    func updateCustomNavigationBar() {
        setCustomNavigationBar(
            customNavigationBarViews(), configuration: customNavigationBarConfiguration()
        )
    }

    func setCustomNavigationBarHidden(_ hidden: Bool, animated: Bool) {
        guard let navBar = customNavigationBarView else { return }

        guard animated else {
            hidNavBar(navBar: navBar, hidden: hidden)
            return
        }

        UIView.transition(with: navBar, duration: 0.2, options: [.beginFromCurrentState]) { [weak self] in
            self?.hidNavBar(navBar: navBar, hidden: hidden)
        } completion: { _ in }
    }

    private func hidNavBar(navBar: CustomNavigationBarView, hidden: Bool) {
        if hidden {
            customNavigationBarAdditionalArea = additionalSafeAreaInsets.top
            additionalSafeAreaInsets.top = 0
        } else {
            additionalSafeAreaInsets.top = customNavigationBarAdditionalArea
        }
        navBar.alpha = hidden ? 0 : 1
        view.layoutIfNeeded()
    }
}
