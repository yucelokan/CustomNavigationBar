//
//  Spacer.swift
//  CustomNavigationBar
//
//  Created by okan.yucel on 28.02.2022.
//

import UIKit

class Spacer: UIView {
    init(width: CGFloat = 0) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        guard width > 0 else { return }
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
