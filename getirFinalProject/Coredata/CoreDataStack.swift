//
//  CoreDataStack.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 21.04.2024.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ShoppingList")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func fetchProductCount(byID productID: String) -> Int? {
        let context = CoreDataStack.shared.context
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", productID)
        fetchRequest.fetchLimit = 1  // We're only interested in one product with this ID

        do {
            let results = try context.fetch(fetchRequest)
            if let product = results.first {
                return Int(product.count)  // Assuming 'count' is stored as Int16 in Core Data
            } else {
                print("No product found with ID \(productID)")
                return nil  // No product found
            }
        } catch {
            print("Failed to fetch product: \(error)")
            return nil  // An error occurred
        }
    }

    
    func addProduct(product: ProductDataModel, count: Int) {
        let context = CoreDataStack.shared.context
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", product.id)

        do {
            let results = try context.fetch(fetchRequest)
            if let existingProduct = results.first {
                // Product exists, update its count
                if count == 0{
                    context.delete(existingProduct)
                }else{
                    existingProduct.count = Int16(count)
                }
            } else {
                let newProduct = NSEntityDescription.insertNewObject(forEntityName: "Product", into: context) as! Product
                newProduct.id = product.id
                newProduct.name = product.name
                newProduct.price = product.price ?? 0
                newProduct.priceText = product.priceText
                newProduct.imageURL = product.imageURL ?? product.squareThumbnailURL ?? product.thumbnailURL ?? ""
                newProduct.count = Int16(count)
                newProduct.productAttr = product.attribute ?? ""
                print("New product added with count \(count).")
            }
            // Save the context after making changes
            try context.save()
            print("Changes successfully saved to Core Data.")
        } catch let error as NSError {
            print("Could not fetch or save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchProducts() -> [Product] {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()

        do {
            return try CoreDataStack.shared.context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func calculateTotalPrice() -> Double {
        let products = fetchProducts()
        let totalFee = products.reduce(0.0) { total, product in
            let productTotal = product.price * Double(product.count)
            return total + productTotal
        }
        return totalFee
    }
    
    func deleteAllProducts() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Product")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try CoreDataStack.shared.context.execute(batchDeleteRequest)
            try CoreDataStack.shared.context.save()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
}
