@_exported import Vapor

extension Droplet {
  public func setup() throws {
    try collection(Routes.self)
    
    let catRest = CatRESTController()
    
    self.get("hello") { request in
      let catRequest = try catRest.index(request)
      let context: Node = try Node(node: ["content":catRequest])
      
      return try self.view.make("base", context)
    }
  }
}
