import HTTP

let config = try Config()
try config.setup()

let drop = try Droplet(config)
try drop.setup()

try drop.resource("kittens", CatRESTController.self)

//let catController = CatsController()
//catController.addRoutes(drop: drop)




















/*
// /cats
// The (request) closure expects 1 of three things:
// 1. throw
// 2. ResponseRepresentable
// 3. Response

drop.get("cats") { (request: Request) in
  let localCat = Cat(name: "Mittens", breed: "Calico", snack: "Salmon")
  
  // This works because we defined localCat as NodeRepresentable
  //return try JSON(node: localCat)
  
  // This works because we defined localCat as JSONRepresentable
  //return try localCat.makeJSON()
  
  
  // This works because we defined localCat as ResponseRepresentable
  // which is one of the 3 things that this close wants to return
  return localCat
  // TODO: make an extension on Array to return Array<JSONRepresentable>
}

// /cute-cats
drop.get("cute-cats") { (request: Request) in
  return try JSON(node: ["mittens" : "american shorthair"])
}

// /specific-cat/<something>
drop.get("specific-cat", ":catID") { (request: Request) in
  
  // How nodes work:
  // Nodes are intermediary object
  guard let catID = request.parameters["catID"]?.string else {
    throw Abort.notFound
  }
  
  return "The cat selected was: \(catID)"
}

// /cats/cute/all
drop.get("cats", "cute", "all") { request in
  return "All the cats!! in /cats/cute/all"
}

// /cats/cute
drop.get("cats", "cute") { request in
  return "All the cats!! in /cats/cute"
}

// /post-cat
drop.post("post-cat") { request in
  return "Posting a new cat!"
}

drop.post("new") { (request: Request) in
  
  guard
    let catName: String = request.json?["cat_name"]?.string,
    let catBreed: String = request.json?["cat_breed"]?.string,
    let catSnack: String = request.json?["cat_snack"]?.string
  else {
    throw Abort.init(Status(statusCode: 900, reasonPhrase: "Dunno"))
  }
  // we'd use the infor to create a new Cat model object
  let localCat = Cat(name: catName, breed: catBreed, snack: catSnack)
  
  return try JSON(node: ["success" : true, "cat_added" : localCat])
}
*/

try drop.run()
