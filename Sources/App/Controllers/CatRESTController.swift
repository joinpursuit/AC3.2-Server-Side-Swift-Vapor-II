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
    return "ALL THE INDEX OF CATS"
  }
  
  func create(_ request: Request) throws -> ResponseRepresentable {
    return "CREATE THE INDEX OF CATS"
  }
  
  // The only way for your resource to work here, is
  // if it conforms to the Model protocol
  func makeResource() -> Resource<Cat> {
    return Resource(index:  index,
                    create: create)
  }
}

// This extension is needed from some forgotten reason
extension CatRESTController: EmptyInitializable {}
