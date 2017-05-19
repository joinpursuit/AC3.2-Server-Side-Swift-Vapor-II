//
//  Cat.swift
//  cat-v2
//
//  Created by Louis Tur on 5/19/17.
//
//

import Foundation
import Vapor

import Fluent
import FluentProvider

final class Cat: Model, NodeInitializable, NodeRepresentable {
  let name: String
  let breed: String
  let snack: String
  
  var storage: Storage = Storage()
  
  required init(node: Node) throws {
    guard
      let catName = node["name"]?.string,
      let catBreed = node["breed"]?.string,
      let catSnack = node["snack"]?.string
    else {
        throw Abort.badRequest
    }
    
    self.name = catName
    self.breed = catBreed
    self.snack = catSnack
  }
  
  init(name: String, breed: String, snack:String) {
    self.name = name
    self.breed = breed
    self.snack = snack
  }
  
  func makeNode(in context: Context?) throws -> Node {
    return try Node(node: ["name":self.name, "breed":self.breed, "snack":self.snack])
  }
  
  // MARK: Persistance Storage / Fluent
  func makeRow() throws -> Row {
    var row = Row()
    try row.set("name", self.name)
    try row.set("breed", self.breed)
    try row.set("snack", self.snack)
    return row
  }
  
  init(row: Row) throws {
    self.name = try row.get("name")
    self.breed = try row.get("breed")
    self.snack = try row.get("snack")
  }
}

// MARK: JSONRepresentable
extension Cat: JSONRepresentable {
  func makeJSON() throws -> JSON {
    return try JSON(node: self)
  }
}

// MARK: ResponseRepresentable
extension Cat: ResponseRepresentable {
  func makeResponse() throws -> Response {
    return try self.makeJSON().makeResponse()
  }
}
