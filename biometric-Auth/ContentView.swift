//
//  ContentView.swift
//  biometric-Auth
//
//  Created by Tornike Despotashvili on 7/14/25.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
  @State private var text: String = "locked"
  @State private var icon: String = "lock.slash"
  @State private var isUnlocked: Bool = false
  
  var body: some View {
    VStack {
      Image(systemName: icon)
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("App is ") + Text(text)
      
      if !isUnlocked {
        Button {
          auth()
        } label: {
          Text("Unlock Phone")
        }
        .buttonStyle(.bordered)
      } else {
        Image("hablo")
          .resizable()
          .scaledToFit()
          .frame(width: 100, height: 100)
      }
    }
    .padding()
  }
  
  @MainActor func auth() {
    let context = LAContext()
    var error: NSError?
    
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "using for test bio auth") { success, error in
        if success {
          text = "unlocked"
          icon = "lock.open"
          isUnlocked = true
        } else {
          text = "Something went wrong!"
        }
      }
    }
    else {
      print("error")
    }
  }
}
