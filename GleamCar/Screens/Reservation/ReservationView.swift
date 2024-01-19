//
//  ReservationsView.swift
//  GleamCar
//
//  Created by Alexander Andrianov on 17.01.2024.
//

import SwiftUI

struct ReservationView: View {
  
  @EnvironmentObject var model:Model
  
  var body: some View {
    let carWash = model.reservation.carWash
    
    NavigationStack {
      if carWash.name.isEmpty {
        NoReservationView()
      } else {
        ScrollView {
          VStack(alignment: .leading) {
            // if car wash name is empty, no reservation has been
            // selected, so, show an unavailable view.
            if carWash.name.isEmpty {
              NoReservationView()
            } else {
              CarWashCell(carWash: carWash)
              
              Divider()
                .padding(.vertical,20)
              
              VStack(alignment: .leading,spacing:8) {
                HStack {
                  Text("Name:")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                  Text(model.reservation.clientName)
                }
                
                HStack {
                  Text("Email:")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                  Text(model.reservation.clientEmail)
                }
                
                HStack {
                  Text("Phone:")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                  Text(model.reservation.clientPhoneNumber)
                }
              } // vstack - contact info
              
              HStack {
                Text("Number of cars:")
                  .foregroundColor(.gray)
                  .font(.subheadline)
                
                Text("\(model.reservation.carsCount)")
                Spacer()
              }
              .padding(.vertical,20) // padding between the "phone" and "date".
              
              VStack(alignment: .leading, spacing:8) {
                HStack {
                  Text("Date:")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                  Text(model.reservation.reservationDate, style: .date)
                    .font(.headline)
                }
                
                HStack {
                  Text("Time:")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                  Text(model.reservation.reservationDate, style: .time)
                    .font(.headline)
                }
              } // vstack - date
              .padding(.bottom,20)
              
              HStack {
                VStack(alignment: .leading) {
                  Text("Special request:")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                  Text(model.reservation.clientSpecialRequest)
                }
              }
            }
          }// main vstack
          .navigationTitle("Reservations")
          .padding(30)
        } // scroll view
      }
    }
  }
}

#Preview {
  ReservationView()
    .environmentObject(Model())
}
