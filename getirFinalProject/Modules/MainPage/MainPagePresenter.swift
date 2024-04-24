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
    func viewDidLoad()
    func viewWillAppear()
    func suggestedProductList() -> [ProductDataModel]
    func allProductList() -> [ProductDataModel]
    var currentProduct : ProductDataModel { get set }
    func didSelectItem(collectionView : CollectionViewEnums ,indexPath : Int)
    func numberOfItems(collectionView : CollectionViewEnums) -> Int
    func plusButtonTapped(indexPathHorizontal : Int?, indexPathVertical : Int?)
    func productCountChanged(count : Int)
}

class MainPagePresenter : MainPagePresentation, MainPageInteractorOutput{
    
    internal var output : MainPageViewContract!
    private var router : MainPageRouting
    let interactor : MainPageInteractorInput!
    
    private var _suggestedProductList = [ProductDataModel]()
    private var _allProductList = [ProductDataModel]()
    var currentProduct: ProductDataModel = ProductDataModel(id: "", imageURL: "", price: nil, name: nil, priceText: nil, shortDescription: nil, category: nil, unitPrice: nil, squareThumbnailURL: nil, status: nil, attribute: nil, thumbnailURL: nil, productCount: 0)
    
    init(router : MainPageRouting, view : MainPageViewContract, interactor : MainPageInteractorInput){
        self.output = view
        self.router = router
        self.interactor = interactor
    }
    
    
    func viewDidLoad() {
        fetchAllProducts()
        fetchSuggestedProducts()
        output.displayTotalPrice(price: CoreDataStack.shared.calculateTotalPrice())
    }
    
    func viewWillAppear(){
        output.displayTotalPrice(price: CoreDataStack.shared.calculateTotalPrice())
    }
    
    func didSelectItem(collectionView: CollectionViewEnums, indexPath: Int) {
        if collectionView == .horizontal{
            currentProduct = _suggestedProductList[indexPath]
            currentProduct.setProductCount(count: CoreDataStack.shared.fetchProductCount(byID: currentProduct.id) ?? 0)
            goPresentDetailPage(product: currentProduct)
        }else if collectionView == .vertical{
            currentProduct = _allProductList[indexPath]
            currentProduct.setProductCount(count: CoreDataStack.shared.fetchProductCount(byID: currentProduct.id) ?? 0)
            goPresentDetailPage(product: currentProduct)
        }
    }
    
    func numberOfItems( collectionView: CollectionViewEnums ) -> Int {
        if collectionView == .horizontal{
            if _suggestedProductList.isEmpty {
                return 0
            } else {
                return _suggestedProductList.count
            }
        }else{
            if _allProductList.isEmpty {
                return 0
            } else {
                return _allProductList.count
            }
        }
    }
    
    func plusButtonTapped(indexPathHorizontal: Int?, indexPathVertical : Int?) {
        if indexPathHorizontal == nil{
            currentProduct = _allProductList[indexPathVertical ?? 0]}
        else{
            currentProduct = _suggestedProductList[indexPathHorizontal ?? 0]
        }
    }
    
    func productCountChanged(count: Int) {
        CoreDataStack.shared.addProduct(product: currentProduct, count: count)
        totalPriceChanged()
    }
    
    func totalPriceChanged(){
        output.displayTotalPrice(price: CoreDataStack.shared.calculateTotalPrice())
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
        _allProductList = modelledList
        output.allProductsFetched(productList: modelledList)
    }
    
    func setFetchAllProductDataFailed(error: String) {
        
    }
    
    func setFetchSuggestedProductDataSuccess(result: [SuggestedProductsResponse]) {
        
        let modelledList = result[0].products.map { product -> ProductDataModel in
            ProductDataModel(id: product.id, imageURL: product.imageURL, price: product.price, name: product.name, priceText: product.priceText, shortDescription: product.shortDescription, category: product.category, unitPrice: product.unitPrice, squareThumbnailURL: product.squareThumbnailURL, status: product.status, attribute: product.attribute, thumbnailURL: product.thumbnailURL, productCount: 0)
        }
        _suggestedProductList = modelledList
        output.suggestedProductsFetched(productList: modelledList)
    }
    
    func suggestedProductList() -> [ProductDataModel] {
        return _suggestedProductList
    }
    
    func allProductList() -> [ProductDataModel] {
        return _allProductList
    }
    
    func goShopingCartScreen() {
        router.presentShoppingCart(from: output)
    }
    
    func setFetchSuggestedProductDataFailed(error: String) {
        
    }
    
    
    
}
