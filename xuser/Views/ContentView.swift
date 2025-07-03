//
//  ContentView.swift
//  xuser
//
//  Created by Hasan Saral on 2.07.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab = Tab.one
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            MainView()
                .tabItem {
                    Label("", systemImage: "globe.europe.africa")
                }
                .tag(Tab.one)
            
            FavoritesView(name: "")
                .tabItem {
                    Label("", systemImage: "heart.circle")
                }
                .tag(Tab.two)
            
        } // TabView
        .accentColor(.red)
        .background(Color.white)
    }
}

public enum Tab: Hashable {
    case one
    case two
}

#Preview {
    ContentView()
}
