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
    
    static func animatedViewStart() {
        let vc = AnimatedViewController(nibName: MyViewControllerType.ANIMATED_VIEW_IDENTIFIER,
                                        bundle: nil)
        
        UIViewController.topViewController?
            .navigationController?
            .pushViewController(vc, animated: true)
    }
    
    static func carouselViewStart() {
        let vc = CarouselViewController(nibName: MyViewControllerType.CAROUSEL_VIEW_IDENTIFIER,
                                        bundle: nil)
        
        UIViewController.topViewController?
            .navigationController?
            .pushViewController(vc, animated: true)
    }
}

enum CoordinatorViewType: String {
    case searchViewController
    case animatedViewController
    case carouselViewController
}

extension CoordinatorViewType {
    func go() {
        switch self {
        case .searchViewController:
            MainCoordinator.searchViewStart()
        case .animatedViewController:
            MainCoordinator.animatedViewStart()
        case .carouselViewController:
            MainCoordinator.carouselViewStart()
        }
    }
    
    var cellTitle: String {
        switch self {
        case .searchViewController:
            return "Rx로 검색 구현"
        case .animatedViewController:
            return "Rx로 Animated Cell"
        case .carouselViewController:
            return "Carousel 구현해보기"
        }
    }
}
