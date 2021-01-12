//
//  PoopDetailTextView.swift
//  PoopTracker
//
//  Created by Sam Lubrano on 11/07/2020.
//

import SwiftUI

struct PoopDetailTextView: View {
    
    let poopRowVM: PoopRowViewModel
    @EnvironmentObject var activityVM: ActivityViewModel
    
    @State private var actionSheetIsShowing = false
    @State var selectedPoop = Poop(time: Date())
    
    func deleteSelectedPoop() {
        activityVM.deletePoop(poop: selectedPoop)
    }
    
    var body: some View {
        
        ForEach(poopRowVM.poops) { poop in
            VStack(alignment: .leading) {
                HStack {
                    Text(poopRowVM.detailTimePeriodFormattedText(withDate: poop.time))
                }
                
                if let poopNote = poop.notes {
                    Text(poopNote)
                        .foregroundColor(.secondary)
                }
                
            }.padding(.bottom, 5)
            .onLongPressGesture {
                selectedPoop = poop
                actionSheetIsShowing.toggle()
            }
        }.actionSheet(isPresented: $actionSheetIsShowing) {
            ActionSheet(title: Text("Delete Poop"), message: Text("Delete poop at \(selectedPoop.timeString()) on \(selectedPoop.dayString())"), buttons: [
                .destructive(Text("Delete")) { deleteSelectedPoop() },
                .cancel()
            ])
        }
        
    }
}

struct PoopDetailView_Previews: PreviewProvider {
    
    static var poopRowVM = PoopRowViewModel(poops: rawPoops, timePeriod: "Day")
    
    static var previews: some View {
        PoopDetailTextView(poopRowVM: poopRowVM)
    }
}
