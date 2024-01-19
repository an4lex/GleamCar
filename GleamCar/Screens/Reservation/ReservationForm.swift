//
//  ReservationForm.swift
//  GleamCar
//
//  Created by Alexander Andrianov on 17.01.2024.
//

import SwiftUI

struct ReservationForm: View {
  
  @EnvironmentObject var model: Model
  @State private var showInvalidFormMessage: Bool = false
  @State private var errorMessage: String = ""
  
  var carWash: CarWash
  @State private var reservationDate = Date()
  @State private var carsCount: Int = 1
  @State private var clientName = ""
  @State private var clientPhoneNumber = ""
  @State private var clientEmail = ""
  @State private var clientSpecialRequest: String = ""
  
  // An action that dismisses the current presentation.
  @Environment(\.dismiss) var dismiss
  
  // stores a temporary reservation used by this view
  @State private var temporaryReservation = Reservation()
  @State private var mustChangeReservation = false
  
  init(_ carWash: CarWash) {
    self.carWash = carWash
  }
  
  var body: some View {
    VStack(alignment: .center) {
      Form {
        // Car Wash information
        VStack(alignment: .leading, spacing:15) {
          Text(carWash.name)
            .font(.title3)
            .fontWeight(.medium)
            .foregroundStyle(Color.white)
          HStack {
            Text(carWash.street)
            Text("-")
            Text(carWash.phoneNumber)
          }
          .font(.footnote)
          .foregroundStyle(Color.white)
        }
        .listRowBackground(Color.customDarkBlue)
        
        HStack {
          Text("Number of cars:")
          // Min cars count: 1, max: 5.
          Stepper("\(carsCount)",
                  value: $carsCount,
                  in: 1...5, step: 1)
          .font(.headline)
          .foregroundStyle(Color.red)
        }
        .padding(.vertical,10)
        
        // Date Picker
        DatePicker("Select a date",
                   selection: $reservationDate,
                   displayedComponents: [.date, .hourAndMinute])
        .padding(.vertical,10)
        
        Group {
          // Name
          HStack {
            Text("Name:")
            TextField("your first and last name",
                      text: $clientName)
          }
          // Phone number
          HStack {
            Text("Phone number:")
            TextField("your phone number",
                      text: $clientPhoneNumber)
            .textContentType(.telephoneNumber)
            .keyboardType(.phonePad)
          }
          // Email
          HStack {
            Text("* Email:").bold()
            TextField("there is an optional choice",
                      text: $clientEmail)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
          }
          // Your special request
          TextField("Your special request...",
                    text: $clientSpecialRequest,
                    axis: .vertical)
          .lineLimit(5)
          .padding()
          .overlay {
            RoundedRectangle(cornerRadius:10)
              .stroke(Color.gray)
              .opacity(0.2)
          }
          
          // Reserve button
          Button {
            validateForm()
          } label: {
            Label("Reserve", systemImage: "checkmark.circle.fill")
          }
          .font(.title3)
          .fontWeight(.medium)
          .buttonStyle(.borderedProminent)
          .tint(Color.customDarkBlue)
          .padding(.top,15)
        }
        .padding(.vertical,8)// group
      } // form
      .scrollContentBackground(.hidden)
      
      .onChange(of: mustChangeReservation) { _ in
        model.reservation = temporaryReservation
      }
      
      // Show an alert if the form is filled in incorrectly.
      .alert("Validation Error", isPresented: $showInvalidFormMessage, actions: {
        Button("OK") { dismiss() }
      }, message: { Text(self.errorMessage) })
    } // vstack
    .onAppear {
      model.displayingReservationForm = true
    }
    .onDisappear {
      model.displayingReservationForm = false
    }
  } // body
  
  private func validateForm() {
    
    let isValidName = isValid(name: clientName)
    let isValidEmail = isValid(email: clientEmail)
    
    guard isValidName && isValidEmail
    else {
      
      var invalidNameMessage = ""
      if clientName.isEmpty || !isValid(name: clientName) {
        invalidNameMessage = "Names can only contain letters and must have at least 3 characters.\n\n"
      }
      
      var invalidEmailMessage = ""
      if !clientEmail.isEmpty || !isValid(email: clientEmail) {
        invalidEmailMessage = "The e-mail is invalid and cannot be blank.\n\n"
      }
      
      var invalidPhoneMessage = ""
      if clientPhoneNumber.isEmpty {
        invalidPhoneMessage = "The phone number cannot be blank."
      }
      
      self.errorMessage = "Found these errors in the form:\n\n\(invalidNameMessage)\(invalidEmailMessage)\(invalidPhoneMessage)"
      
      // Presents a warning alert with all errors that the user must correct.
      showInvalidFormMessage.toggle()
      return
    }
    
    // Form is valid, create new temporary reservation.
    let temporaryReservation = Reservation(carWash: carWash,
                                           clientName: clientName,
                                           clientEmail: clientEmail,
                                           clientPhoneNumber: clientPhoneNumber,
                                           clientSpecialRequest: clientSpecialRequest,
                                           carsCount: carsCount,
                                           reservationDate: reservationDate)
    
    // Store the temporary reservation locally.
    self.temporaryReservation = temporaryReservation
    
    // Set the flag to defer changing to the model (see .onChange).
    self.mustChangeReservation.toggle()
    
    // Dismiss this view.
    self.dismiss()
  }
  
  // Full name validation.
  func isValid(name:String) -> Bool {
    guard !name.isEmpty,
            name.count > 2
    else { return false }
    for chr in name {
      if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr == " ") ) {
        return false
      }
    }
    return true
  }
  
  // Validation for client email
  func isValid(email:String) -> Bool {
    guard !email.isEmpty else { return false }
    let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
    
    // "NSPredicate" is a class that is used to create search conditions or filter data.
    let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
    return emailValidationPredicate.evaluate(with: email)
  }
}

#Preview {
  ReservationForm(CarWash())
    .environmentObject(Model())
}
