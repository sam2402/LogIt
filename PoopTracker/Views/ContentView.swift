//
//  ContentView.swift
//  PoopTracker
//
//  Created by Sam Lubrano on 03/07/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = 0
    
    var activityVM = ActivityViewModel()
    
    var body: some View {
        
        NavigationView {
            MyActivityView().environmentObject(activityVM)
        }
        
        /*
        TabView(selection: $selectedTab) {
            
            NavigationView {
                MyActivityView().environmentObject(activityVM)
            }.tag(0)
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 0 ? "flame.fill" : "flame")
                        Text("My Activity")
                    }
                }
            
            
            NavigationView {
                FriendsActivityView()
            }.tag(1)
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 1 ? "person.3.fill" : "person.3")
                        Text("Friends' Activity")
                    }
                }
            
            NavigationView {
                MyProfileView()
            }.tag(2)
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 2 ? "person.circle.fill" : "person.circle")
                        Text("My Profile")
                    }
                }
 
        }
        */
 
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
