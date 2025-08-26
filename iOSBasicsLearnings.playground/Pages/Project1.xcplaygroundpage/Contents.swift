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

//    •    Define a MarketError enum (productNotFound, invalidQty, outOfStock).
enum MarketError: Error {
    case productNotFound
    case MarketError
    case invalidQty
    case outOfStock
}

//    •    Use an enum with raw values for Category (e.g., electronics, grocery, apparel).
enum Category: String {
    
    case electronics = "electronics"
    case grocery = "grocery"
    case apparel = "apparel"
    // to have array of items let's use switch
    var items: [String] {
        switch self {
        case .electronics:
            return ["TV", "Laptop", "Speakers"]
        case .grocery:
            return ["Bread", "Milk", "Eggs"]
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

//Protocols
//
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

//    •    Show protocol composition in at least one function parameter.
// two ways to show protocol composition, typealies name = protocolOne & protocol two
// second method struct name: ProtocolOne, ProtocolTwo. according to stackoverflow typealies name = p1 & p2 is better to use
typealias protcolCombination = Priceable & Discountable


//    •    Add a default implementation via protocol extensions (POP style).
extension Discountable {
    // below computed property priceAfterDiscount
    var priceAfterDiscount: Double {
        price * (1 - discount)
    }
}

//let promo = Discountable(CartItem(product: Product(id: 1, name: "Phone", category: .electronics, price: 1000), quantity: 1), discount: 0.2)
//print("Price after discount:",promo.priceAfterDiscount)

//    •    Define a Product (struct) with id, name, category, price.
// MODEL
struct Product: IdentifiableEntity, Priceable {
    var id: Int
    var name: String
    var category: Category
    var price: Double

}

//    •    Define a CartItem (struct) that holds a product and quantity.
struct CartItem: IdentifiableEntity {
    var id: Int
    
    
    var product: Product
    var quantity: Int
    
}

//used Generics, Associated Type
//
//    •    Create a generic Repository with an associatedtype Item.
protocol Repository {
    associatedtype Item: IdentifiableEntity //
    func find(_ id: Int) -> Item?
    func all() -> [Item]
}

//    •    Implement a generic in-memory repository for products or cart items.
struct InMemoryRepository<T: IdentifiableEntity>: Repository {
    private var items: [T] = []
    func all() -> [T] {
        return items
    }
    
    
    mutating func add(_ item: T) {
        items.append(item)
    }
    
    func find(_ id: Int) -> T? {
        items.first { $0.id == id }
    }
}

//Services
//

//    •    Create a base class Service.
class Service {
    var name: String = "BaseService"
    

    
}

//    •    Inherit InventoryService (manages products) and CartService (manages cart & totals).
class InventoryService: Service {
    private var productRepository = InMemoryRepository<Product>()
    
    override init() {
        super.init()
        self.name = "InventoryService"
    }
    func product(withId id: Int) -> Product? {
        return productRepository.find(id) as? Product
    }

    
    func addProduct() {
        print("addProduct",addProduct)
    }
    
    func getAllProducts() -> [Product] {
        return productRepository.all()
    }
    

}
// CartService (manages cart & totals). // totalCarts?
class CartService: Service {
    private var cartRepository = InMemoryRepository<CartItem>()
    override init() {
        super.init()
        self.name = "CartService"
    }
    func cartItems() -> [CartItem] {
        return cartRepository.all()
    }

//    func cartRepository() -> InMemoryRepository<CartItem> {
//        return cartRepository
//    }
    

    

}

// Global marketplace instance for standalone functions
nonisolated(unsafe) var marketplace = InventoryService()
nonisolated(unsafe) var cart = CartService()

//Expected Features
//
//
//    •    Add products to catalog. // where to add in InventoryService?
func productCatalogAdd(_ product: Product) -> Void {
    marketplace.addProduct(product)
}

//    •    Search products by closure filter, usage
func productCatalogSearch(_ filter: (Product) -> Bool) -> [Product] {
    return marketplace.productRepository.all().filter(filter)
}

productCatalogAdd(Product(id: 1, name: "iPhone", category: .electronics, price: 999.99))
productCatalogAdd(Product(id: 2, name: "Bread", category: .grocery, price: 2.99))
productCatalogAdd(Product(id: 3, name: "T-Shirt", category: .apparel, price: 19.99))
productCatalogAdd(Product(id: 4, name: "Laptop", category: .electronics, price: 1299.99))
var testProducts: [Product] = []
testProducts = productCatalogSearch { $0.category == .grocery }
print(testProducts)

//    •    Add/remove products to/from cart.
func addToCart(_ productId: Int, _ qty: Int) throws -> Void {
    return try cart.cartRepository.add(productId: productId, qty: qty)
    
}
func removeFromCart(_ productId: Int) -> Void {
    return cart.cartRepository.add(productId: productId, qty: -1)
}

// Add to cart with error handling
do {
    try addToCart(1, 2)
    try addToCart(2, 5)
    try addToCart(3, 1)
} catch MarketError.productNotFound {
    print("Product not found!")
} catch MarketError.invalidQty {
    print("Invalid quanty")
} catch MarketError.outOfStock {
    print("Out of stock")
}


//    •    Apply discount rules (flat and percent).
func applyDiscount(_ rules: [PriceRule]) -> Void {
    cart.applyDiscount(rules)
}
applyDiscount([.flat(10), .percent(5)])

//    •    Print cart summary (total, discount applied, grouped by category).
func printCartSummary() -> Void {
    cart.printCartSummary()
}


//    •    Use map, filter, reduce, compactMap to:

//    ◦    Extract product names.
func getProductNames() -> [String] {
    // return use map to get product names
    return marketplace.getAllProducts().map { $0.name }
}

//    ◦    Filter products by category.
func getProductsByCategory(_ category: Category) -> [Product] {
    // return .filter
    return marketplace.getAllProducts().filter { $0.category == category }
}

//    ◦    Compute cart total.
func computeCartTotal() -> Int {
    return cart.cartItems().count
}

//    ◦    Remove invalid coupons (compactMap).
func removeInvalidCoupons(_ coupons: [String?]) -> [String] {
//    if coupons == inValidCoupon {
//        // then remove, but how do we know if the coupon is not valid?
//    }
}

//    •    Use closures for:
//    ◦    Searching/filtering products (search(whereClause:)).
func search(whereClause: ((Product) -> Bool)?) -> [Product] {
    // return
    guard let whereClause = whereClause else {
        return marketplace.getAllProducts()
    }
    return marketplace.getAllProducts().filter(whereClause)
}

// Search products
let expensiveProducts = productCatalogSearch { $0.price > 100 }
print("Expensive products: ",expensiveProducts)

////    ◦    Sorting products (inline comparator).
//nonisolated(unsafe) var porducts: [String] = ["a", "b", "c"]
func sortProductsByName(_ product: inout [Product]) -> [Product] {
    return marketplace.getAllProducts().sorted { $0.name < $1.name }
}

//    ◦    Trailing closure syntax at least once.
func traverseProducts(_ products: [Product], using closure: ((Product) -> Void)?) {
    guard products.count > 0 else { return }
    for product in products {
        closure?(product)
    }

}



