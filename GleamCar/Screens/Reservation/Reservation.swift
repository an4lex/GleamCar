//
//  Reservation.swift
//  GleamCar
//
//  Created by Alexander Andrianov on 18.01.2024.
//

import Foundation

struct Reservation {
  var id = UUID()
  
  var carWash: CarWash
  var clientName: String
  var clientEmail: String
  var clientPhoneNumber: String
  var clientSpecialRequest: String
  var carsCount: Int
  var reservationDate: Date
  
  init(carWash: CarWash = CarWash(),
       clientName: String = "",
       clientEmail: String = "",
       clientPhoneNumber: String = "",
       clientSpecialRequest: String = "",
       carsCount: Int = 0,
       reservationDate: Date = Date() ) {
    self.carWash = carWash
    self.clientName = clientName
    self.clientEmail = clientEmail
    self.clientPhoneNumber = clientPhoneNumber
    self.clientSpecialRequest = clientSpecialRequest
    self.carsCount = carsCount
    self.reservationDate = reservationDate
  }
}
