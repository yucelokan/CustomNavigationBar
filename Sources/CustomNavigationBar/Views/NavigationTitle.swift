//
//  NavigationTitle.swift
//  CustomNavigationBar
//
//  Created by okan.yucel on 28.02.2022.
//

import UIKit

public class NavigationTitle: UILabel {
    public init(
        _ title: String,
        font: UIFont,
        numberOfLines: Int,
        tintColor: UIColor,
        minimumScaleFactor: CGFloat = 0.5,
        lineBreakMode: NSLineBreakMode = .byTruncatingMiddle
    ) {
        super.init(frame: .zero)
        self.textAlignment = .center
        self.text = title
        self.font = font
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = minimumScaleFactor
        self.textColor = tintColor
        self.numberOfLines = numberOfLines
        self.lineBreakMode = lineBreakMode
        accessibilityIdentifier = NavigationTitle.navigationTitleID
        heightAnchor.constraint(greaterThanOrEqualToConstant: 16).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var navigationTitleID: String {
        return "navigation_title"
    }
}
