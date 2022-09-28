//
//  CustomNavigationBar.swift
//  
//
//  Created by okan.yucel on 12.03.2022.
//

import UIKit

public struct CustomNavigationBar {
    
    public static var configuration = CustomNavigationBarConfiguration()
    public static func setupCustomNavigationBar() {
        UIViewController.setupCustomNavigationBar()
    }
  
    static var customNavigationBarAdditionalArea: [String: CGFloat] = [:]
}
