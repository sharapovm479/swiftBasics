//: [Previous](@previous)

import Foundation

//Will check assignment tomorrow.
//Assignment 1 — Mini Marketplace System
//
//
//
//Problem Statement
//
//
//You are tasked with designing a Mini Marketplace system in Swift. The system should allow users to browse products, add items to a cart, apply discounts, and compute totals.
//
//The design should be modular and demonstrate good use of Swift language features.
//
//
//
//
//Requirements
//
//
//
//Models

//
//
//Services
//
//
//Protocols
//
//
//Generics & Associated Type
//
//
//Closures
//
//
//Higher-Order Functions
//
//
//Error Handling
//Expected Features
//
//
//    •    Add products to catalog.
//    •    Search products by closure filter.
//    •    Add/remove products to/from cart.
//    •    Apply discount rules (flat and percent).
//    •    Print cart summary (total, discount applied, grouped by category).
//
//
//
//
//    •    Define a MarketError enum (productNotFound, invalidQty, outOfStock).
//    •    Throw and handle errors in addToCart.
//    •    Use map, filter, reduce, compactMap to:
//    ◦    Extract product names.
//    ◦    Filter products by category.
//    ◦    Compute cart total.
//    ◦    Remove invalid coupons (compactMap).
//    •    Use closures for:
//    ◦    Searching/filtering products (search(whereClause:)).
//    ◦    Sorting products (inline comparator).
//    ◦    Trailing closure syntax at least once.
//    •    Create a generic Repository with an associatedtype Item.
//    •    Implement a generic in-memory repository for products or cart items.
//    •    Create protocols for IdentifiableEntity and Priceable.
//    •    Demonstrate protocol inheritance (Discountable: Priceable).
//    •    Show protocol composition in at least one function parameter.
//    •    Add a default implementation via protocol extensions (POP style).
//    •    Create a base class Service.
//    •    Inherit InventoryService (manages products) and CartService (manages cart & totals).
//    •    Define a Product (struct) with id, name, category, price.
//    •    Define a CartItem (struct) that holds a product and quantity.
//    •    Use an enum with raw values for Category (e.g., electronics, grocery, apparel).
//    •    Use an enum with associated values for PriceRule (flat(Double), percent(Double)).
//


//
//You are tasked with designing a Mini Marketplace system in Swift. The system should allow users to browse products, add items to a cart, apply discounts, and compute totals.
//
//The design should be modular and demonstrate good use of Swift language features.
//
//
//Models
//
// MARK: - Structs- Models

//    •    Define a Product (struct) with id, name, category, price.
struct Product: IdentifiableEntity, Priceable {
    var id: Int
    var name: String
    var category: Category
    var price: Double
}

//    •    Define a CartItem (struct) that holds a product and quantity.
struct CartItem {
    var product: Product
    var quantity: Int
}

//    •    Define a MarketError enum (productNotFound, invalidQty, outOfStock).
enum MarketError: Error {
    case productNotFound
    case invalidQty
    case outOfStock
}

//    •    Use an enum with raw values for Category (e.g., electronics, grocery, apparel).
enum Category: String {
    case electronics
    case grocery
    case apparel
    var items:[String] {
        switch self {
        case .electronics:
            return ["TV", "Speakers", "Laptop"]
        case .grocery:
            return ["Bread", "Milk", "Apples"]
        case .apparel:
            return ["T-shirts", "Jeans", "Shoes"]
        }
    }
}

//    •    Use an enum with associated values for PriceRule (flat(Double), percent(Double)).
enum PriceRule {
    case flat(Double)
    case percent(Double)
}

// MARK: - Protocols

//    •    Create protocols for IdentifiableEntity and Priceable.
protocol IdentifiableEntity {
    var id: Int { get }
}

protocol Priceable {
    var price: Double { get }
}

//    •    Demonstrate protocol inheritance (Discountable: Priceable).
protocol Discountable: Priceable {
    var discount: Double { get }
}

//    •    Add a default implementation via protocol extensions (POP style).
extension Discountable {
    var priceAfterDiscount: Double {
        price * (1 - discount)
    }
}



// MARK: - Generics & Repository

//    •    Create a generic Repository with an associatedtype Item.
protocol Repository {
    associatedtype Item: IdentifiableEntity
    func find(_ id: Int) -> Item?
    func all() -> [Item]
    func add(_ item: Item)
    func remove(_ id: Int)
}

//    •    Implement a generic in-memory repository for products or cart items.
class InMemoryRepository<T: IdentifiableEntity>: Repository {
    private var items: [T] = []
    
    func all() -> [T] {
        return items
    }
    
    func add(_ item: T) {
        items.append(item)
    }
    
    func find(_ id: Int) -> T? {
        items.first { $0.id == id }
    }
    
    func remove(_ id: Int) {
        items.removeAll { $0.id == id }
    }
}

// MARK: - Services

//    •    Create a base class Service.
class Service {
    var name: String = "BaseService"
}


// MARK: - Global instances

let inventory = InventoryService()
let cart = CartService()

//protocol MarketPlaceProt {
//    let inventory: InventoryService() { get }
//    let cart: CartService() { get }
//}
//
struct MarketplaceStruct {
let inventory: InventoryService
}
protocol InvetorryProvidingDepInversion {
//    func product(withID id: Int) -> Product?
}


//    •    Inherit InventoryService (manages products) and CartService (manages cart & totals).
class InventoryService: Service {
    
    private var productRepository = InMemoryRepository<Product>()
    
    func addProduct(_ product: Product) {
        productRepository.add(product)
    }
    
    func getAllProducts() -> [Product] {
        productRepository.all()
    }
    
    func product(withId id: Int) -> Product? {
        productRepository.find(id)
    }
}

class CartService: Service {
    private var items: [CartItem] = []
    private var discountAmount: Double = 0
    
    func addToCart(productId: Int, qty: Int, inventory: InventoryService) throws {
        guard qty > 0 else { throw MarketError.invalidQty }
        guard let product = inventory.product(withId: productId) else {
            throw MarketError.productNotFound
        }
        
        if let index = items.firstIndex(where: { $0.product.id == productId }) {
            items[index].quantity += qty
        } else {
            items.append(CartItem(product: product, quantity: qty))
        }
    }
    
    func removeFromCart(productId: Int) {
        items.removeAll { $0.product.id == productId }
    }
    
    func applyDiscountRules(_ rules: [PriceRule]) {
        let subtotal = items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
        discountAmount = 0
        
        for rule in rules {
            switch rule {
            case .flat(let amount):
                discountAmount += amount
            case .percent(let percent):
                discountAmount += subtotal * (percent / 100)
            }
        }
    }
    
    func calculateTotal() -> Double {
        let subtotal = items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
        return subtotal - discountAmount
    }
    
    func printSummary() {
        let grouped = Dictionary(grouping: items) { $0.product.category }
        
        for (category, items) in grouped {
            print("\(category):")
            for item in items {
                print(" \(item.product.name): $\(item.product.price) x \(item.quantity)")
            }
        }
        let subtotal = items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
        print("Subtotal: $\(subtotal)")
        print("Discount: $\(discountAmount)")
        print("Total: $\(calculateTotal())")
    }
}





// MARK: - Expected Features

//    •    Add products to catalog.
@MainActor func productCatalogAdd(_ product: Product) {
    inventory.addProduct(product)
}

//    •    Search products by closure filter.
@MainActor func productCatalogSearch(_ filter: (Product) -> Bool) -> [Product] {
    inventory.getAllProducts().filter(filter)
}

//    •    Add/remove products to/from cart.
@MainActor func addToCart(_ productId: Int, _ qty: Int) throws {
    try cart.addToCart(productId: productId, qty: qty, inventory: inventory)
}

@MainActor func removeFromCart(_ productId: Int) {
    cart.removeFromCart(productId: productId)
}

//    •    Apply discount rules (flat and percent).
@MainActor func applyDiscount(_ rules: [PriceRule]) {
    cart.applyDiscountRules(rules)
}

//    •    Print cart summary (total, discount applied, grouped by category).
@MainActor func printCartSummary() {
    cart.printSummary()
}

// MARK: - Higher-Order Functions

//    ◦    Extract product names.
@MainActor func getProductNames() -> [String] {
    inventory.getAllProducts().map { $0.name }
}

//    ◦    Filter products by category.
@MainActor func getProductsByCategory(_ category: Category) -> [Product] {
    inventory.getAllProducts().filter { $0.category == category }
}

//    ◦    Compute cart total.
@MainActor func computeCartTotal() -> Double {
    cart.calculateTotal()
}

//    ◦    Remove invalid coupons (compactMap).
func removeInvalidCoupons(_ coupons: [String?]) -> [String] {
    let validCoupons = ["SAVE10", "SUMMER20"]
    return coupons.compactMap { $0 }.filter { validCoupons.contains($0) }
}

// MARK: - Closures

//    ◦    Searching/filtering products (search(whereClause:)).
@MainActor func search(whereClause: (Product) -> Bool) -> [Product] {
    inventory.getAllProducts().filter(whereClause)
}

//    ◦    Sorting products (inline comparator).
func sortProductsByName(_ products: inout [Product]) -> [Product] {
    products.sort { $0.name < $1.name }
    return products
}

//    ◦    Trailing closure syntax at least once.
func traverseProducts(_ products: [Product], using closure: (Product) -> Void) {
    products.forEach { closure($0) }
}

//    •    Show protocol composition in at least one function parameter.
func processDiscountableItem(_ item: Priceable & Discountable) {
    print("Price: \(item.price), After discount: \(item.priceAfterDiscount)")
}
//typealias protolComName = Priceable & Discountable


