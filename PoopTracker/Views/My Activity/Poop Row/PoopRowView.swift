//
//  PoopRowView.swift
//  PoopTracker
//
//  Created by Sam Lubrano on 11/07/2020.
//

import SwiftUI

struct PoopRowView: View {
    
    @ObservedObject var poopRowVM: PoopRowViewModel
    
    @State private var detailViewIsShowing = false
    
    var body: some View {
        
        HStack(alignment: .top) {
            Text(String(poopRowVM.poops.count))
                .font(.system(size: 45, design: .rounded))
                .bold()
                .foregroundColor(poopRowVM.numberColor())
                .frame(minWidth: 35)
                .padding(.top, -7)
            VStack(alignment: .leading) {
                Text(poopRowVM.timePeriodFormattedText())
                    .font(.headline)
                if !detailViewIsShowing {
                    PoopThumbnailTextView(poopArray: poopRowVM.poops)
                } else {
                    PoopDetailTextView(poopRowVM: poopRowVM)
                }

            }
            Spacer()

            if !poopRowVM.poops.isEmpty {
                Image(systemName: "chevron.right")
                    .rotationEffect(.degrees(detailViewIsShowing ? 90 : 0))
                    .font(Font.body.weight(.bold))
                    .foregroundColor(.secondary)
            }

        }
        .animation(.default)
        .contentShape(Rectangle())
        .highPriorityGesture(
            TapGesture()
                .onEnded({ _ in
                    if !poopRowVM.poops.isEmpty {
                        detailViewIsShowing.toggle()
                    }
                })
        )
        
    }
}

struct PoopRow_Previews: PreviewProvider {
    
    static var poopRowVM = PoopRowViewModel(poops: rawPoops, timePeriod: "Day")
    
    static var previews: some View {
        PoopRowView(poopRowVM: poopRowVM)
            
    }
}
