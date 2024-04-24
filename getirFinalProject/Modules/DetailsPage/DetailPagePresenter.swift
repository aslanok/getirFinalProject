//
//  DetailPagePresenter.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 19.04.2024.
//

import Foundation

protocol DetailPagePresentation{
    func viewWillAppear()
    func back()
    func goShopingCartScreen()
    func productCountUpdated(count : Int)
}

class DetailPagePresenter : DetailPagePresentation{
    
    internal var output : DetailPageViewContract!
    private var router : DetailPageRouting
    var currentProduct : ProductDataModel
    
    init(currentProduct : ProductDataModel,output: DetailPageViewContract!, router: DetailPageRouting) {
        self.currentProduct = currentProduct
        self.output = output
        self.router = router
    }
    
    func viewWillAppear() {
        output.displayTotalPrice(price: CoreDataStack.shared.calculateTotalPrice())
    }
    
    func productCountUpdated(count: Int) {
        CoreDataStack.shared.addProduct(product: currentProduct, count: count)
        output.displayTotalPrice(price: CoreDataStack.shared.calculateTotalPrice())
        output.adjustComponents(count: count)
    }
    
    func goShopingCartScreen() {
        router.presentShoppingCart(from: output)
    }
    
    func back() {
        router.back(from: output)
    }
    
    
    
}
