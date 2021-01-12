//
//  AuthenticationService.swift
//  PoopTracker
//
//  Created by Peter Friese
//

import Foundation
import Firebase
import Resolver

class AuthenticationService: ObservableObject {

  @Published var user: User?
  
  func signIn() {
    registerStateListener()
    Auth.auth().signInAnonymously()
  }
  
  private func registerStateListener() {
    Auth.auth().addStateDidChangeListener { (auth, user) in
      print("Sign in state has changed.")
      self.user = user
      
      if let user = user {
        let anonymous = user.isAnonymous ? "anonymously " : ""
        print("User signed in \(anonymous)with user ID \(user.uid).")
      }
      else {
        print("User signed out.")
      }
    }
  }
  
}

extension Resolver: ResolverRegistering {
  public static func registerAllServices() {
    register { AuthenticationService() }.scope(application)
  }
}
