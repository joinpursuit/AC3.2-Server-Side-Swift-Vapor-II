//
//  CatsController.swift
//  cat-v2
//
//  Created by Louis Tur on 5/19/17.
//
//

import Foundation
import Vapor
import HTTP

// Simple Controllers manage route registering in a basic way: refactoring code out of another file.. like the main.swift
class CatsController {
  
  // this func is all a simple controller needs to follow convention
  func addRoutes(drop: Droplet) {
    
    /*
     drop.get("cats") { response in
     let localCat = Cat(name: "Mittens", breed: "Calico", snack: "Salmon")
     return localCat
     }*/
    drop.get("cat", handler: getCat)
    drop.get("cats", handler: getCats)
    drop.post("new", handler: postCats)
  }
  
  // GET /cats
  // (Request) throws -> ResponseRepresentable
  func getCat(request: Request) throws -> ResponseRepresentable {
    let localCat = Cat(name: "Senator Meowser", breed: "Tuxedo", snack: "Salmon")
    return localCat
  }
  
  func getCats(request: Request) throws -> ResponseRepresentable {
    let cat1 = Cat(name: "Senator Meowser", breed: "Tuxedo", snack: "Salmon")
    let cat2 = Cat(name: "Senator Meowser", breed: "Tuxedo", snack: "Salmon")
    let cat3 = Cat(name: "Senator Meowser", breed: "Tuxedo", snack: "Salmon")
    
     return try JSON(node: [cat1, cat2, cat3])
    //return try [cat1, cat2, cat3].asResponse()
  }
  
  // POST /new
  func postCats(request: Request) throws -> ResponseRepresentable {
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
  
}

// TODO: fix this up... maybe
extension Array where Element: ResponseRepresentable {
  func asResponse() throws -> ResponseRepresentable {
    return try JSON(node: self.flatMap{ try? $0.makeResponse() })
  }
}
