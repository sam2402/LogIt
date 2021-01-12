//
//  Poop.swift
//  PoopTracker
//
//  Created by Sam Lubrano on 03/07/2020.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Poop: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String?
    var time: Date
    var notes: String?
}

#if DEBUG
let rawPoops = [
    
    Poop(time: Date(timeIntervalSinceNow: -86400), notes: "Constipated"),
    Poop(time: Date(timeIntervalSinceNow: -16400), notes: "Constipated"),
    Poop(time: Date(timeIntervalSinceNow: -16400), notes: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor"),

    Poop(time: Date(timeIntervalSinceNow: -259200)),

    Poop(time: Date(timeIntervalSinceNow: 0), notes: "Constipated"),
    Poop(time: Date(timeIntervalSinceNow: -172800), notes: "Constipated"),
    Poop(time: Date(timeIntervalSinceNow: -172800), notes: "Bran Flakes"),
    Poop(time: Date(timeIntervalSinceNow: -100740)),

    Poop(time: Date(timeIntervalSinceNow: -259200), notes: "Constipated"),


    Poop(time: Date(timeIntervalSinceNow: -86400), notes: "Constipated"),
    Poop(time: Date(timeIntervalSinceNow: -56400)),
    Poop(time: Date(timeIntervalSinceNow: -16400), notes: "Hard"),
    Poop(time: Date(timeIntervalSinceNow: -16400), notes: "Hard"),
    Poop(time: Date(timeIntervalSinceNow: -16400), notes: "Hard"),
    Poop(time: Date(timeIntervalSinceNow: -1640000), notes: "Hard"),
    Poop(time: Date(timeIntervalSinceNow: -1640000), notes: "Hard"),
    Poop(time: Date(timeIntervalSinceNow: -1640000), notes: "Hard"),
    Poop(time: Date(timeIntervalSinceNow: -1640000), notes: "Hard"),
    Poop(time: Date(timeIntervalSinceNow: -1640000), notes: "Hard"),
    Poop(time: Date(timeIntervalSinceNow: -1640000), notes: "Hard"),
    Poop(time: Date(timeIntervalSinceNow: -1640000), notes: "Hard"),
    Poop(time: Date(timeIntervalSinceNow: -1640000), notes: "Hard"),
    Poop(time: Date(timeIntervalSinceNow: -1640000), notes: "Hard"),
    Poop(time: Date(timeIntervalSinceNow: -1640000), notes: "Hard"),
    Poop(time: Date(timeIntervalSinceNow: -1640000), notes: "Hard"),

    Poop(time: Date(timeIntervalSinceNow: -259200))

]
#endif
