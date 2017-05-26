//
//  CatPageController.swift
//  cat-v2
//
//  Created by Louis Tur on 5/25/17.
//
//

import Foundation
import Vapor

final class CatPageController {
  private let drop: Droplet!
  
  init(drop: Droplet) {
    self.drop = drop
  }
  
  func setupRoutes() {
    // this lets us group our route by a common path component
    let views = self.drop.grouped("view")
    
    // this handles /view
    views.get("", handler: index)
    views.get(":name", handler: indexCustom)
    views.get("all", handler: all)
  }
  
  func index(request: Request) throws -> ResponseRepresentable {
    
    let phrases = ["Bienvenue", "Welcome", "Velkommen", "Willkommen", "Добро пожаловат", "ようこそ"]
    let randomPhrase = phrases[Int(arc4random_uniform(UInt32(phrases.count)))].appending(", Leaf!")
    
    return try self.drop.view.make("base", Node(node: ["welcome": randomPhrase]))
  }
  
  func indexCustom(request: Request) throws -> ResponseRepresentable {
    guard let param = request.parameters["name"]?.string else {
      throw Abort.badRequest
    }
    
    return try self.drop.view.make("base", Node(node: ["name": param]))
  }
  
  func all(request: Request) throws -> ResponseRepresentable {
    // query all of our cats
    let cats =  try Cat.all().makeJSON()

    // return our base.leaf, passing it some content in a Node
    return try self.drop.view.make("messages", Node(node: ["content": cats, "image" : "/images/classy_kitty.png"]))
  }
}
