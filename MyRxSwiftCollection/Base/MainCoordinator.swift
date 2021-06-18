//
//  MainCoordinator.swift
//  MyRxSwiftCollection
//
//  Created by Jinseok Hwang on 2021/06/18.
//

import UIKit

struct MainCoordinator {
    static func searchViewStart() {
        let vc = SearchViewController(nibName: MyViewControllerType.SEARCH_VIEW_IDENTIFIER,
                         bundle: nil)
        
        UIViewController.topViewController?
            .navigationController?
            .pushViewController(vc, animated: true)
    }
}
