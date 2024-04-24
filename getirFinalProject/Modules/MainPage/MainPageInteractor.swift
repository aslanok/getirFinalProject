//
//  MainPageInteractor.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 19.04.2024.
//

import Foundation

protocol MainPageInteractorInput{
    func executeAllProducts()
    func executeSuggestedProducts()
}

protocol MainPageInteractorOutput{
    func setFetchAllProductDataSuccess(result : [AllProductsResponse])
    func setFetchAllProductDataFailed(error : String)
    func setFetchSuggestedProductDataSuccess(result : [SuggestedProductsResponse])
    func setFetchSuggestedProductDataFailed(error : String)
}

class MainPageInteractor : MainPageInteractorInput{
    
    internal var output : MainPageInteractorOutput?
    
    let endpointAllProductsURL = "https://65c38b5339055e7482c12050.mockapi.io/api/products"
    let endpointSuggestedProductsURL = "https://65c38b5339055e7482c12050.mockapi.io/api/suggestedProducts"
    
    func executeAllProducts() {
        APIService.shared.request( endpointAllProductsURL, type: [AllProductsResponse].self) { result in
            switch result{
            case .success(let data):
                self.output?.setFetchAllProductDataSuccess(result: data)
            case .failure(let error):
                self.output?.setFetchAllProductDataFailed(error: error.errorDescription)
            }
        }
    }
    
    func executeSuggestedProducts() {
        APIService.shared.request( endpointSuggestedProductsURL, type: [SuggestedProductsResponse].self) { result in
            switch result{
            case .success(let data):
                self.output?.setFetchSuggestedProductDataSuccess(result: data)
            case .failure(let error):
                self.output?.setFetchSuggestedProductDataSuccess(result: [SuggestedProductsResponse(products: [ProductResponse(id: "6540f93a48e4bd7bf4940ffd", imageURL: "https://market-product-images-cdn.getirapi.com/product/dee83b80-7f9a-4aea-b799-e3316b5696f1.jpg", price: 140.75, name: " Master Nut NR1 Mixed Nuts", priceText: "₺140,75", shortDescription: "140 g", category: nil, unitPrice: nil, squareThumbnailURL: nil, status: nil, attribute: nil, thumbnailURL: nil), ProductResponse(id: "61dc4659b93cd396c7a742fc", imageURL: "https://market-product-images-cdn.getirapi.com/product/ad25df11-6d82-4a9d-8ad8-d86aa8ce1fd3.jpg", price: 33.6, name: "Doritos Risk Super Size", priceText: "₺33,60", shortDescription: nil, category: nil, unitPrice: nil, squareThumbnailURL: nil, status: nil, attribute: nil, thumbnailURL: nil), ProductResponse(id: "5ce65819a72a950001cc8770", imageURL: "https://market-product-images-cdn.getirapi.com/product/82fb0f6f-640f-40ee-b8b7-d2e9c1bd1dd3.jpg", price: 32.5, name: "Doritos Extreme Mexicano Hot Spicy Corn Chips", priceText: "₺32,50", shortDescription: nil, category: nil, unitPrice: nil, squareThumbnailURL: nil, status: nil, attribute: nil, thumbnailURL: nil), ProductResponse(id: "5ceae038c461e70001cc9808", imageURL: "https://market-product-images-cdn.getirapi.com/product/27145620-42ac-45bb-8c11-8b43e3e48123.jpg", price: 87.99, name: "Exotic Lemonade", priceText: "₺87,99", shortDescription: nil, category: "551430043427d5010a3a5c5e", unitPrice: nil, squareThumbnailURL: nil, status: nil, attribute: nil, thumbnailURL: nil), ProductResponse(id: "559843a0b1dc700c006a72b7", imageURL: "http://cdn.getir.com/product/559843a0b1dc700c006a72b7_tr_1614078382858.jpeg", price: 132.95, name: "Peyman Bahçeden Assorted Mixed", priceText: "₺132,95", shortDescription: nil, category: nil, unitPrice: 949.6429, squareThumbnailURL: nil, status: nil, attribute: nil, thumbnailURL: nil), ProductResponse(id: "5d9359501cf86cf22d3122f6", imageURL: "https://market-product-images-cdn.getirapi.com/product/9191e03f-63e6-4c99-83b4-3d67ded029a6.jpg", price: 33.6, name: "Ruffles Ketchup Potato Chips Super Size", priceText: "₺33,60", shortDescription: nil, category: nil, unitPrice: nil, squareThumbnailURL: nil, status: nil, attribute: nil, thumbnailURL: nil), ProductResponse(id: "5ce6581dfd9b330001c4a8af", imageURL: "https://market-product-images-cdn.getirapi.com/product/c66128a5-2e67-426e-8935-8c9a7db8c676.jpg", price: 42.99, name: "Ruffles Ketchup Potato Chips Party Size", priceText: "₺42,99", shortDescription: nil, category: nil, unitPrice: nil, squareThumbnailURL: nil, status: nil, attribute: nil, thumbnailURL: nil), ProductResponse(id: "563b52c9fd069b0c001f2f46", imageURL: nil, price: 43.99, name: "Biscolata Mood Cup", priceText: "₺43,99", shortDescription: nil, category: nil, unitPrice: nil, squareThumbnailURL: "https://market-product-images-cdn.getirapi.com/product/ba383655-374f-42ac-8c21-49b144448c9d.jpg", status: nil, attribute: nil, thumbnailURL: nil), ProductResponse(id: "59024d406532a700044604c0", imageURL: nil, price: 33, name: "Coca-Cola Zero Sugar", priceText: "₺33,00", shortDescription: nil, category: nil, unitPrice: nil, squareThumbnailURL: "https://market-product-images-cdn.getirapi.com/product/2565e217-c3b5-488e-8d9d-799f832ef299.jpg", status: nil, attribute: nil, thumbnailURL: nil), ProductResponse(id: "5ce6581efd9b330001c4a8e2", imageURL: nil, price: 32.5, name: "Doritos Turca Poppy Seeds & Tomato Corn Chips Super Size", priceText: "₺32,50", shortDescription: nil, category: nil, unitPrice: nil, squareThumbnailURL: "https://market-product-images-cdn.getirapi.com/product/90b8bf4b-a6b3-4be4-ade3-49a1d5d1bb39.jpg", status: 1, attribute: nil, thumbnailURL: nil), ProductResponse(id: "59e87cdcaee4410004c89a0e", imageURL: nil, price: 28.1, name: "Eker Efsane Yogurt", priceText: "₺28,10", shortDescription: nil, category: nil, unitPrice: nil, squareThumbnailURL: "https://market-product-images-cdn.getirapi.com/product/982de90e-817a-4a5e-ac46-d3f924863e56.jpg", status: nil, attribute: nil, thumbnailURL: nil), ProductResponse(id: "5ced482f4a8a2a000137da80", imageURL: nil, price: 29.99, name: "Lemons", priceText: "₺29,99", shortDescription: nil, category: nil, unitPrice: nil, squareThumbnailURL: "https://cdn.getir.com/product/2_limon_5ced482f4a8a2a000137da80.png", status: nil, attribute: nil, thumbnailURL: nil) ], id: "66", name: nil)] )
                //self.output?.setFetchSuggestedProductDataFailed(error: error.errorDescription)
            }
        }
    }
    
}
