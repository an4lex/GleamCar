//
//  LocationsView.swift
//  GleamCar
//
//  Created by Alexander Andrianov on 17.01.2024.
//

import SwiftUI

struct LocationView: View {
  
  @EnvironmentObject var model: Model
  @State private var selectedCarWash: CarWash?
  
  var body: some View {
    VStack(alignment: .center,spacing:35) {
      
      // Application logo.
      HStack(spacing:15) {
        Image("car").resizable()
          .frame(width: 50, height: 50)
        Text("Gleam Car")
          .font(.title2)
          .fontWeight(.medium)
      }
      
      Button("Select a location on map", systemImage: "mappin") {
        // When this button is tapped, redirect the user to Map Screen.
        // On the card screen the user can see the car wash nearby as well as check the own location.
      }
      .foregroundStyle(Color.white)
      .tint(Color.customDarkBlue)
      .buttonStyle(.borderedProminent)
      
      // When the user selects a car wash, show a reservation form.
      List(model.carWashStations, id: \.self) { carWash in
        CarWashCell(carWash: carWash)
          .onTapGesture { selectedCarWash = carWash }
        // display the reservation form.
          .sheet(item: $selectedCarWash) { carWash in
            ReservationForm(carWash)
              .presentationDragIndicator(.visible)
          }
      }.listStyle(.plain)
    } // main VStack
    .padding(.top,15)
    .scrollContentBackground(.hidden)
    .environmentObject(model)
  }
}

#Preview {
  LocationView()
    .environmentObject(Model())
}
