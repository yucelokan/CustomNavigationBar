//
//  UIStackView+Extensions.swift
//  CustomNavigationBar
//
//  Created by okan.yucel on 25.02.2022.
//

import UIKit

extension UIStackView {
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { allSubviews, subview -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }

        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap(\.constraints))

        // Remove the views from self
        removedSubviews.forEach { $0.removeFromSuperview() }
    }
}
