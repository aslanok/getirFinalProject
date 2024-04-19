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
    func goPresentDetailPage(product : ProductResponse)
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
    
    func goPresentDetailPage(product: ProductResponse) {
        router.presentDetailPage(product: product,from: output)
    }
    
    func fetchAllProducts() {
        interactor.executeAllProducts()
    }
    
    func fetchSuggestedProducts(){
        interactor.executeSuggestedProducts()
    }
    
    func setFetchAllProductDataSuccess(result: [AllProductsResponse]) {
        output.allProductsFetched(productList: result)
    }
    
    func setFetchAllProductDataFailed(error: String) {
        
    }
    
    func setFetchSuggestedProductDataSuccess(result: [SuggestedProductsResponse]) {
        output.suggestedProductsFetched(productList: result)
    }
    
    func setFetchSuggestedProductDataFailed(error: String) {
        
    }
    
    
    
}
