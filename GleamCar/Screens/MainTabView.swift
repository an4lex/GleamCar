//
//  MainTabView.swift
//  GleamCar
//
//  Created by Alexander Andrianov on 17.01.2024.
//

import SwiftUI

struct MainTabView: View {
  @StateObject private var model = Model()
  
  var body: some View {
    TabView {
      LocationView()
        .tabItem {
          Label("Locations", systemImage: "location.fill")
        }
      ReservationView()
        .tabItem {
          Label("Reservations", systemImage: "square.and.pencil")
        }
    } // tab view
    .environmentObject(model)
  }
}

#Preview {
  MainTabView()
}
