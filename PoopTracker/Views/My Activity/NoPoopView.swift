//
//  NoPoopView.swift
//  PoopTracker
//
//  Created by Sam Lubrano on 21/07/2020.
//

import SwiftUI

struct NoPoopView: View {
    var body: some View {
        VStack {
            Text("Doesn't look like you've done any poops")
            Text("Tap \"Add Poop\" to note one down")
        }.foregroundColor(.secondary)
        .font(.headline)
        .multilineTextAlignment(.center)
        .padding()
    }
}

struct NoPoopView_Previews: PreviewProvider {
    static var previews: some View {
        NoPoopView()
    }
}
