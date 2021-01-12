//
//  PoopThumbnailTextView.swift
//  PoopTracker
//
//  Created by Sam Lubrano on 03/07/2020.
//

import SwiftUI
import Foundation

struct PoopThumbnailTextView: View {
    
    let poopArray: [Poop]
    
    var body: some View {
        Text(poopArray.notesPreview())
            .foregroundColor(.secondary)
            .lineLimit(1)
    }
}

struct PoopThumbnailView_Previews: PreviewProvider {
    
    static var poopRowVM = PoopRowViewModel(poops: rawPoops, timePeriod: "Day")
    
    static var previews: some View {
        PoopThumbnailTextView(poopArray: poopRowVM.poops)
    }
}
