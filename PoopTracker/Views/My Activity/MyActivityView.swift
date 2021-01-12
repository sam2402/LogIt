//
//  MyActivityView.swift
//  PoopTracker
//
//  Created by Sam Lubrano on 10/07/2020.
//

import SwiftUI

struct MyActivityView: View {
    
    @EnvironmentObject var activityVM: ActivityViewModel
    
    @State private var addPoopSheetIsShowing = false
    @State private var chosenTimeScale = 0
    
    private var timeScales = ["Day", "Week", "Month"]
    
    func toggleAddPoopSheet() {
        self.addPoopSheetIsShowing.toggle()
    }
    
    func changeTimePeriod(_ timePeriodTag: Int) {
        let timePeriod = timeScales[timePeriodTag]
        activityVM.setTimePeriod(to: timePeriod)
    }
    
    var body: some View {
        VStack {
            
            Picker(selection: $chosenTimeScale.onChange(changeTimePeriod), label: Text("") ) {
                ForEach(0..<timeScales.count) { index in
                    Text("\(timeScales[index])")
                }
            }.padding(.horizontal)
            .pickerStyle(SegmentedPickerStyle())
            
            if !activityVM.poops.isEmpty {
                
                List(activityVM.poopRowViewModels) { poopRowViewModel in
                    PoopRowView(poopRowVM: poopRowViewModel)
                }.listStyle(PlainListStyle())
                
            } else {
                Spacer()
                NoPoopView()
                Spacer()
            }
            
        }.navigationBarTitle("Log It")
        .navigationBarItems(
            
            leading:
                    
                VStack {
                    if !activityVM.poops.isEmpty {
                        Button(action: { activityVM.toggleEmptyRows() }) {
                            Image(systemName: activityVM.emptyRowsAreShowing ? "circle.fill": "circle")
                            Text("Show Empty \(timeScales[chosenTimeScale])s")
                        }
                    }
                },
            
            trailing:
                
                Button(action: { self.toggleAddPoopSheet() }) {
                    Image(systemName: "plus")
                    Text("Add Poop")
                }

        )
        
        .sheet(isPresented: $addPoopSheetIsShowing) {
            AddPoopSheetView(isShowing: $addPoopSheetIsShowing).environmentObject(activityVM)
        }
    }
}

struct MyActivityView_Previews: PreviewProvider {
    static var previews: some View {
        MyActivityView()
    }
}
