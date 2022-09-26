//
//  NavigationButton.swift
//  CustomNavigationBar
//
//  Created by okan.yucel on 28.02.2022.
//

import UIKit

public class NavigationButton: UIButton {
    public init(
        image: UIImage?,
        tint: CustomNavigationBarButtonTintColor,
        action: @escaping () -> Void
    ) {
        self.action = action
        super.init(frame: .zero)
        
        switch tint {
        case .original:
            setImage(image, for: .normal)
        case .withColor(let color):
            imageView?.tintColor = color
            setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
      
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
        widthAnchor.constraint(equalToConstant: 48).isActive = true
        contentHorizontalAlignment = .center
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layer.zPosition = 1
    }
    
    private var action: () -> Void
    
    @objc private func didTap() {
        action()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateAligment() {
        contentHorizontalAlignment = getAligment
    }
    
    var getAligment: UIControl.ContentHorizontalAlignment {
        guard let superCenterX = superview?.center.x else { return .center }
        guard superCenterX > center.x else { return .right }
        guard superCenterX < center.x else { return .left }
        return .center
    }
    
}
