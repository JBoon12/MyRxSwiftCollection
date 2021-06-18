//
//  UIViewController + Extensions.swift
//  MyRxSwiftCollection
//
//  Created by Jinseok Hwang on 2021/06/18.
//

import UIKit

extension UIViewController {
    
    static var topViewController: UIViewController? {
        return topViewController(rootViewController: UIApplication.shared.keyWindow?.rootViewController)
    }
    
    private
    static func topViewController(rootViewController: UIViewController?) -> UIViewController? {
        if let navigationController = rootViewController as? UINavigationController {
            return topViewController(rootViewController: navigationController.viewControllers.last)
        }
        if let tabController = rootViewController as? UITabBarController {
            return topViewController(rootViewController: tabController.selectedViewController)
        }
        if let presentedViewController = rootViewController?.presentedViewController {
            return topViewController(rootViewController: presentedViewController)
        }
        
        return rootViewController
    }
}
