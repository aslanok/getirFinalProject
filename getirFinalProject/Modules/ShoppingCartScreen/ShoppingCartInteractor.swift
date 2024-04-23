//
//  ShoppingCartInteractor.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 23.04.2024.
//

import Foundation

protocol ShoppingCartInteractorInput{
    func execute()
}

protocol ShoppingCartInteractorOutput{
    func setFetchSuggestedProductSucceed(result : [ProductDataModel])
    func setFetchSuggestedProductFailed(error : String)
}

class ShoppingCartInteractor : ShoppingCartInteractorInput{
    
    internal var output : ShoppingCartInteractorOutput?
    let endpointSuggestedProductsURL = "https://65c38b5339055e7482c12050.mockapi.io/api/suggestedProducts"

    func execute() {
        APIService.shared.request( endpointSuggestedProductsURL, type: [SuggestedProductsResponse].self) { result in
            switch result{
            case .success(let data):
                print("data : \(data)")
                let result = data[0].products.map { product ->
                    ProductDataModel in
                    ProductDataModel(id: product.id, imageURL: product.imageURL, price: product.price, name: product.name, priceText: product.priceText, shortDescription: product.shortDescription, category: product.category, unitPrice: product.unitPrice, squareThumbnailURL: product.squareThumbnailURL, status: product.status, attribute: product.attribute, thumbnailURL: product.thumbnailURL, productCount: 0)
                }
                print("result : \(result)")
                self.output?.setFetchSuggestedProductSucceed(result: result)
            case .failure(let error):
                self.output?.setFetchSuggestedProductFailed(error: error.errorDescription)
            }
        }
    }
    
}
