//
//  MainPagePresenter.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 17.04.2024.
//

import Foundation

protocol MainPagePresentation{
    func fetchAllProducts()
    func fetchSuggestedProducts()
    func goPresentDetailPage(product : ProductDataModel)
    func goShopingCartScreen()
}


class MainPagePresenter : MainPagePresentation, MainPageInteractorOutput{
    
    internal var output : MainPageViewContract!
    private var router : MainPageRouting
    let interactor : MainPageInteractorInput!
    
    init(router : MainPageRouting, view : MainPageViewContract, interactor : MainPageInteractorInput){
        self.output = view
        self.router = router
        self.interactor = interactor
    }
    
    func goPresentDetailPage(product: ProductDataModel) {
        router.presentDetailPage(product: product,from: output)
    }
    
    func fetchAllProducts() {
        interactor.executeAllProducts()
    }
    
    func fetchSuggestedProducts(){
        interactor.executeSuggestedProducts()
    }
    
    func setFetchAllProductDataSuccess(result: [AllProductsResponse]) {
        
        let modelledList = result[0].products!.map { product -> ProductDataModel in
            ProductDataModel(id: product.id, imageURL: product.imageURL, price: product.price, name: product.name, priceText: product.priceText, shortDescription: product.shortDescription, category: product.category, unitPrice: product.unitPrice, squareThumbnailURL: product.squareThumbnailURL, status: product.status, attribute: product.attribute, thumbnailURL: product.thumbnailURL, productCount: 0)
        }
        output.allProductsFetched(productList: modelledList)
    }
    
    func setFetchAllProductDataFailed(error: String) {
        
    }
    
    func setFetchSuggestedProductDataSuccess(result: [SuggestedProductsResponse]) {
        
        let modelledList = result[0].products.map { product -> ProductDataModel in
            ProductDataModel(id: product.id, imageURL: product.imageURL, price: product.price, name: product.name, priceText: product.priceText, shortDescription: product.shortDescription, category: product.category, unitPrice: product.unitPrice, squareThumbnailURL: product.squareThumbnailURL, status: product.status, attribute: product.attribute, thumbnailURL: product.thumbnailURL, productCount: 0)
        }
        
        output.suggestedProductsFetched(productList: modelledList)
    }
    
    func goShopingCartScreen() {
        router.presentShoppingCart(from: output)
    }
    
    func setFetchSuggestedProductDataFailed(error: String) {
        
    }
    
    
    
}
