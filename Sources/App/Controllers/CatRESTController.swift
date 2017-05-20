//
//  CatRESTController.swift
//  cat-v2
//
//  Created by Louis Tur on 5/19/17.
//
//

import Foundation
import Vapor

final class CatRESTController: ResourceRepresentable {
  func index(_ request: Request) throws -> ResponseRepresentable {
    return try Cat.all().makeJSON()
  }
  
  func create(_ request: Request) throws -> ResponseRepresentable {
    guard
      let catName = request.json?["cat_name"]?.string,
      let catBreed = request.json?["cat_breed"]?.string,
      let catSnack = request.json?["cat_snack"]?.string else {
        throw Abort.badRequest
    }
    
    let newCat = Cat(name: catName, breed: catBreed, snack: catSnack)
    try newCat.save()
    return try JSON(node: ["success": true, "cat" : newCat])
  }
  
  func show(_ request: Request, param: Cat) throws -> ResponseRepresentable {
    
    
    return "Hello"
  }
  
  // The only way for your resource to work here, is
  // if it conforms to the Model protocol
  func makeResource() -> Resource<Cat> {
    return Resource(index:  index,
                    store: create,
                    show: show)
  }
}

// This extension is needed from some forgotten reason
extension CatRESTController: EmptyInitializable {}
