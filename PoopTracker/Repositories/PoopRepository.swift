//
//  PoopRepository.swift
//  PoopTracker
//
//  Created by Sam Lubrano on 15/07/2020.
//

import Foundation
import Combine
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Resolver

class PoopRepository: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Injected var authenticationService: AuthenticationService
    var userId: String = "unknown"
    
    @Published var poops = [Poop]()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
        authenticationService.$user
              .compactMap { user in
                user?.uid
              }
              .assign(to: \.userId, on: self)
              .store(in: &cancellables)
            
        // (re)load data if user changes
        authenticationService.$user
              .receive(on: DispatchQueue.main)
              .sink { user in
                self.loadData()
              }
              .store(in: &cancellables)
        
    }
    
    func loadData() {
        
        db.collection("poops")
            .whereField("userId", isEqualTo: self.userId)
            .addSnapshotListener { querySnapshot, error in
            if let querySnapshot = querySnapshot {
                self.poops = querySnapshot.documents.compactMap { document in
                    try? document.data(as: Poop.self)
                }
            } else {
                print("Error loading data")
            }
        }
        
    }
    
    func addPoop(_ poop: Poop) { 
        var addedPoop = poop
        addedPoop.userId = Auth.auth().currentUser?.uid
        
        do {
            let _ = try db.collection("poops").addDocument(from: addedPoop)
        } catch {
            print("Error adding document: \(error.localizedDescription)")
        }
        
    }
    
    func deletePoop(_ poop: Poop) {
        if let poopId = poop.id {
            db.collection("poops").document(poopId).delete() { err in
                if let err = err {
                    print("Error removing document: \(err.localizedDescription)")
                }
            }
        } else {
            print("Poop does not have an id")
        }
    }
    
}
