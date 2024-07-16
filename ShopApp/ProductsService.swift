import Combine

final class ProductsService {
  @Published private var products: [String] = []
  
  private var subscriptions = Set<AnyCancellable>()
  
  init() {
    Bus.receiveSync(&subscriptions, [K.initialProducts]) { [weak self] (_, v: [String]) in
      self?.products = v
    }
    
    Bus.sendSync(&subscriptions, K.products, $products.eraseToAnyPublisher())
  }
}
