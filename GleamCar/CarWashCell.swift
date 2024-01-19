//
//  CarWashStationCell.swift
//  GleamCar
//
//  Created by Alexander Andrianov on 17.01.2024.
//

import SwiftUI

struct CarWashCell: View {
  
  var carWash: CarWash
  
  var body: some View {
    HStack(spacing:20) {
      // Image
      Image(systemName: "car.fill")
        .imageScale(.large)
        .foregroundStyle(Color.customIndigo)
      
      // Information about car wash, like name, street and phone number.
      VStack(alignment: .leading, spacing:8) {
        Text(carWash.name)
          .font(.headline)
          .fontWeight(.medium)
        HStack {
          Text(carWash.street)
          Text("-")
          Text(carWash.phoneNumber)
        }
        .font(.footnote)
        .foregroundStyle(Color.gray)
      }
    } // main HStack
  }
}

#Preview {
  CarWashCell(carWash: CarWash(name: "Test Station 1", street: "Test Street 1", phoneNumber: "(067)-681-68-68"))
}
