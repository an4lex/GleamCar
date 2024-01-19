//
//  Model.swift
//  GleamCar
//
//  Created by Alexander Andrianov on 17.01.2024.
//

import Foundation

class Model: ObservableObject {
  
  // The data in this array will be filled with information from the server.
  let carWashStations: [CarWash] = [
    CarWash(name: "Shine'n Splash", street: "вул. Азовська", phoneNumber: "(067)-593-23-03"),
    CarWash(name: "AquaGleam", street: "вул. Хрещатик", phoneNumber: "(067)-684-98-44"),
    CarWash(name: "SparkleSurge", street: "вул. Чкалова", phoneNumber: "(067)-725-05-65"),
    CarWash(name: "Vehicle Spa", street: "вул. Балтійська", phoneNumber: "(067)-686-68-68")
  ]
  
  @Published var reservation = Reservation()
  @Published var temporaryReservation = Reservation()
  // When it's true, reservation form will be shown above this screen.
  @Published var displayingReservationForm = false
}
