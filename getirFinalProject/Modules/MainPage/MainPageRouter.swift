//
//  MainPageRouter.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 16.04.2024.
//

import UIKit

protocol MainPageRouting{
    func presentDetailPage(product : ProductDataModel,from view : UIViewController?)
    func presentShoppingCart(from view : UIViewController)
}


class MainPageRouter : MainPageRouting{
    
    var viewController : UIViewController {
        let view = MainPageViewController()
        let interactor = MainPageInteractor()
        
        let presenter = MainPagePresenter(router: self, view: view, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        presenter.output = view
        return view
    }
    
    func presentDetailPage(product : ProductDataModel,from view: UIViewController?) {
        let router = DetailPageRouter()
        view?.present(router.viewController(product: product), animated: true)
    }
    
    func presentShoppingCart(from view: UIViewController) {
        let router = ShoppingCartRouter()
        view.present(router.viewController(), animated: true)
    }
    

    
}
