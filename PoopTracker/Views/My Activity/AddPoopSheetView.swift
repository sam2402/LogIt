//
//  AddPoopSheetView.swift
//  PoopTracker
//
//  Created by Sam Lubrano on 03/07/2020.
//

import SwiftUI

struct AddPoopSheetView: View {
    
    var stoolScaleValues = ["1", "2"]//1, 2, 3, 4, 5, 6, 7]
    
    @Binding var isShowing: Bool
    @EnvironmentObject var activityVM: ActivityViewModel
    
    @State private var date = Date()
    @State private var notes = ""
    
    func addPoop() {
        var addedNotes: String?
        if notes != "" {
            addedNotes = notes
        }
        let newPoop = Poop(time: date, notes: addedNotes)
        activityVM.addPoop(poop: newPoop)
        self.isShowing.toggle()
    }
    
    var body: some View {
        VStack {
            
            HStack {
                Button(action: { self.isShowing.toggle() }) {
                    Text("Cancel")
                        .bold()
                }
                Spacer()
            }
            
            DatePicker("Set the time and date of your poop", selection: $date, in: Date(timeIntervalSinceNow: -157680000)...Date())
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .frame(maxHeight: 400)
            
            TextField("Add any notes about your poop", text: $notes)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(height: 40)
            
            Button(action: { self.addPoop() }) {
                ZStack {
                    Color.accentColor
                    HStack {
                        Image(systemName: "plus")
                            .font(Font.body.weight(.bold))
                        Text("Add Poop")
                            .bold()
                    }
                    .foregroundColor(Color.white)
                    
                }.frame(height: 36)
                .frame(maxWidth: .infinity)
                .cornerRadius(4.0)
            }
            Spacer()
        }.keyboardAdaptive()
        .padding()
        
    }
}

struct AddPoopSheetView_Previews: PreviewProvider {
    
    static let activityViewModel = ActivityViewModel()
    
    static var previews: some View {
        AddPoopSheetView(isShowing: .constant(true))
            
    }
}
