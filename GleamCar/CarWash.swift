//
//  WashStation.swift
//  GleamCar
//
//  Created by Alexander Andrianov on 17.01.2024.
//

import Foundation

struct CarWash: Hashable, Identifiable {
  var id = UUID()
  var name: String
  var street: String
  var phoneNumber: String
  
  init(name: String = "",
       street: String = "",
       phoneNumber: String = "") {
    self.name = name
    self.street = street
    self.phoneNumber = phoneNumber
  }
}
