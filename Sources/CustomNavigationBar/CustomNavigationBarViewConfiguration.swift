//
//  CustomNavigationBarViewConfiguration.swift
//  CustomNavigationBar
//
//  Created by okan.yucel on 28.02.2022.
//

import UIKit
 
public protocol CustomNavigationBarViewConfiguration: AnyObject {
    func customNavigationBarViews() -> [CustomNavigationBarViewType]
    func customNavigationBarConfiguration() -> CustomNavigationBarConfiguration
    func setCustomNavigationBar(_ views: [CustomNavigationBarViewType], configuration: CustomNavigationBarConfiguration)
    var customNavigationBarView: CustomNavigationBarView? { get }
    var customNavigationBarAdditionalArea: CGFloat { get set }
}

public extension CustomNavigationBarViewConfiguration where Self: UIViewController {
    
    func setCustomNavigationBar(
        _ views: [CustomNavigationBarViewType],
        configuration: CustomNavigationBarConfiguration = .init()
    ) {
        clearCustomNavigationBar()
        
        let customNavBar = (self as? CustomNavigationBarConfigurable)?.customNavigationBarView
        let wrappedCustomNavBar = customNavBar ?? CustomNavigationBarView.initFromNib()
        
        let navBarViews = views.getViews(viewController: self, configuration: configuration)
        wrappedCustomNavBar.configureUI(
            views: navBarViews, configuration: configuration
        )
        
        navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let additionalArea = wrappedCustomNavBar.additionalSafeAreaInset
        (self as? CustomNavigationBarConfigurable)?.customNavigationBarAdditionalArea = additionalArea
        additionalSafeAreaInsets = .init(
            top: additionalArea, left: 0, bottom: 0, right: 0
        )
        
        view.addSubview(wrappedCustomNavBar)
        
        let height = additionalArea + wrappedCustomNavBar.stretchTop
        
        wrappedCustomNavBar.translatesAutoresizingMaskIntoConstraints = false
        wrappedCustomNavBar.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        let guide = view.safeAreaLayoutGuide
        
        wrappedCustomNavBar.heightAnchor.constraint(equalToConstant: height).isActive = true
        wrappedCustomNavBar.topAnchor.constraint(equalTo: guide.topAnchor, constant: -height).isActive = true
        wrappedCustomNavBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        wrappedCustomNavBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        view.setNeedsUpdateConstraints()
        view.updateConstraintsIfNeeded()
        
        wrappedCustomNavBar.updateAligments()
    }
    
    func customNavigationBarViews() -> [CustomNavigationBarViewType] {
        let title = (self as? CustomNavigationBarConfigurable)?.customTitle ?? ""
        guard isModal else {
            guard navigationController?.viewControllers.first == self else {
                guard let index = navigationController?.viewControllers.firstIndex(of: self), index > 1 else {
                    return [.pop(), .title(title), .spacer(48)]
                }
                return [.pop(), .title(title), .popToRoot()]
            }
            return [.spacer(48), .title(title), .spacer(48)]
        }
        return [.spacer(48), .title(title), .dismiss()]
    }
    
    func customNavigationBarConfiguration() -> CustomNavigationBarConfiguration {
        return CustomNavigationBar.configuration
    }
    
    var customNavigationBarAdditionalArea: CGFloat {
        get {
            let key = String(describing: self)
            return CustomNavigationBar.customNavigationBarAdditionalArea[key] ?? 0
        }
        set {
            let key = String(describing: self)
            CustomNavigationBar.customNavigationBarAdditionalArea[key] = newValue
        }
    }
    
    var customNavigationBarView: CustomNavigationBarView? {
        guard let customView = view.subviews.first(
            where: {$0.accessibilityIdentifier == CustomNavigationBarView.navigationBarIdentifier}
        ) as? CustomNavigationBarView else {
            return nil
        }
        return customView
    }
}
