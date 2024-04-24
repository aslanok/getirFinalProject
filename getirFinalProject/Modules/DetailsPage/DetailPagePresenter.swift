//
//  DetailPagePresenter.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 19.04.2024.
//

import Foundation

protocol DetailPagePresentation{
    func back()
    func goShopingCartScreen()
}

class DetailPagePresenter : DetailPagePresentation{
    
    internal var output : DetailPageViewContract!
    private var router : DetailPageRouting
    
    init(output: DetailPageViewContract!, router: DetailPageRouting) {
        self.output = output
        self.router = router
    }
    
    func goShopingCartScreen() {
        router.presentShoppingCart(from: output)
    }
    
    func back() {
        router.back(from: output)
    }
    
    
    
}
