//
//  CustomNavigationBarConfiguration.swift
//  CustomNavigationBar
//
//  Created by okan.yucel on 28.02.2022.
//

import UIKit

public struct CustomNavigationBarConfiguration {
    public init() { }
    
    public var margin: UIEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
    public var backgroundColor: UIColor = .clear
    public var titleTintColor: UIColor = .darkText
    public var titleFont: UIFont = .boldSystemFont(ofSize: 17)
    public var minimumScaleFactor: CGFloat = 0.5
    public var lineBreakMode: NSLineBreakMode = .byTruncatingMiddle
    public var titleNumberOfLines: Int = 0
    public var buttonTintColor: CustomNavigationBarButtonTintColor = .withColor(.darkText)
    public var spacing: CGFloat = 0
    public var height: CGFloat = 44
    
    private var _statusBarColor: UIColor?
    public var statusBarColor: UIColor {
        get {
            return _statusBarColor ?? backgroundColor
        }
        set {
            _statusBarColor = newValue
        }
    }
    
    public var popButtonImage: UIImage? = UIImage(
        named: "ic16BackIos", in: .module, compatibleWith: .none
    )
    
    public var dismissButtonImage: UIImage? = UIImage(
        named: "ic16Close", in: .module, compatibleWith: .none
    )
}
