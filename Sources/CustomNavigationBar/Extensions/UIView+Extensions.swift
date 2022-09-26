//
//  UIView+Extensions.swift
//  CustomNavigationBar
//
//  Created by okan.yucel on 25.02.2022.
//

import UIKit

extension UIView {
    static func initFromNib() -> Self {
        guard let view = UINib(nibName: String(describing: self), bundle: .module)
                .instantiate(withOwner: nil, options: nil).first as? Self else {
                    fatalError("Could not init view")
                }
        return view
    }
}
