//
//  ContentUnavailableView.swift
//  GleamCar
//
//  Created by Alexander Andrianov on 19.01.2024.
//

import SwiftUI

struct NoReservationView: View {
  var body: some View {
    VStack {
      Image("noReservation")
        .resizable()
        .frame(width: 150, height: 150)
      Text("No Reservation Yet")
        .font(.title2)
        .fontWeight(.semibold)
        .padding(.top,20)
    }
  }
}

#Preview {
  NoReservationView()
}
