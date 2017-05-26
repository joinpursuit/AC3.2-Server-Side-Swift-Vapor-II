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
  
  // (Request) throws -> ResponseRepresentable
  // aka. typealias Multiple
  func index(_ request: Request) throws -> ResponseRepresentable {
    //let cat1 = Cat(name: "Senator Meowser", breed: "Tuxedo", snack: "Salmon")
    //let cat2 = Cat(name: "Commander JellyBean Toes", breed: "Calico", snack: "Turkey")
    //let cat3 = Cat(name: "President Jangles", breed: "Sphynx", snack: "Apple")
  
    // SELECT * FROM cats;
    // SELECT (cat_name, cat_breed) FROM cats;
    return try Cat.all().makeJSON()
    //return try JSON(node: [cat1, cat2, cat3])
  }
  
  
  // creating a new cat
  // POST request /catREST
  func store(_ request: Request) throws -> ResponseRepresentable {
    
    guard
      let catName = request.json?["cat_name"]?.string,
      let catBreed = request.json?["cat_breed"]?.string,
      let catSnack = request.json?["cat_snack"]?.string else {
        throw Abort.badRequest
    }
    
    let newCat = Cat(name: catName, breed: catBreed, snack: catSnack)
    try newCat.save()
    
    return try JSON(node: ["success" : true, "cat" : newCat])
  }
  
  // (Request, Model) throws -> ResponseRepresentable
  func show(_ request: Request, _ model: Cat) throws -> ResponseRepresentable {
    return model
  }
  
  func makeResource() -> Resource<Cat> {
    return Resource(index: index, // all
                    store: store,  //
                    show: show, // individual resource
                    update: nil,
                    destroy: nil
                )
  }
  
}

extension CatRESTController: EmptyInitializable {}
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  /*func index(_ request: Request) throws -> ResponseRepresentable {
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
  
  func show(_ request: Request, cat: Cat) throws -> ResponseRepresentable {
    return cat
  }
  
  // The only way for your resource to work here, is
  // if it conforms to the Model protocol
  public func makeResource() -> Resource<Cat> {
    return Resource(index:  index,
                    store: create,
                    show: show)
  }*/

// This extension is needed from some forgotten reason
//extension CatRESTController: EmptyInitializable {}
