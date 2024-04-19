//
//  MainPageRouter.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 16.04.2024.
//

import UIKit

protocol MainPageRouting{
    func presentDetailPage(from view : UIViewController?)
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
    
    func presentDetailPage(from view: UIViewController?) {
        //let router = DetailPageRouter()
        //view?.present(router.viewController(coin: coin), animated: true)
    }
    

    
}
