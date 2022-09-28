//
//  CustomNavigationBarButtonType.swift
//  CustomNavigationBarButtonType
//
//  Created by okan.yucel on 25.02.2022.
//

import UIKit

public enum CustomNavigationBarButtonTintColor {
    case withColor(UIColor)
    case original
}

public enum CustomNavigationBarViewType {
    /// Pop view controller to back when selected.
    case pop(CustomNavigationBarButtonTintColor? = nil)
    /// Pop view controller to root when selected.
    case popToRoot(CustomNavigationBarButtonTintColor? = nil)
    /// Dismiss view controller selected.
    case dismiss(CustomNavigationBarButtonTintColor? = nil)
    /// spacer
    case spacer(CGFloat = 0)
    // title
    case title(String)
    // custom
    case custom(UIView)

}

extension Array where Element == CustomNavigationBarViewType {
    func getViews(viewController: UIViewController, configuration: CustomNavigationBarConfiguration) -> [UIView] {
        return compactMap { element in
            switch element {
            case .dismiss(let buttonTintColor):
                let image = configuration.dismissButtonImage
                let tint = buttonTintColor ?? configuration.buttonTintColor
                return NavigationButton(image: image, tint: tint) { [weak viewController] in
                    viewController?.dismiss(animated: true, completion: nil)
                }
            case .pop(let buttonTintColor):
                let image = configuration.popButtonImage
                let tint = buttonTintColor ?? configuration.buttonTintColor
                return NavigationButton(image: image, tint: tint) { [weak viewController] in
                    viewController?.navigationController?.popViewController(animated: true)
                }
            case .popToRoot(let buttonTintColor):
                let image = configuration.dismissButtonImage
                let tint = buttonTintColor ?? configuration.buttonTintColor
                return NavigationButton(image: image, tint: tint) { [weak viewController] in
                    viewController?.navigationController?.popToRootViewController(animated: true)
                }
            case .spacer(let width):
                return Spacer(width: width)
            case .title(let title):
                return NavigationTitle(
                    title,
                    font: configuration.titleFont,
                    numberOfLines: configuration.titleNumberOfLines,
                    tintColor: configuration.titleTintColor,
                    minimumScaleFactor: configuration.minimumScaleFactor,
                    lineBreakMode: configuration.lineBreakMode
                )
            case .custom(let view):
                return view
            }
        }
    }
}
