//
//  xuserApp.swift
//  xuser
//
//  Created by Hasan Saral on 2.07.2025.
//

import SwiftUI

@main
struct xuserApp: App {
    var body: some Scene {
        
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [User.self, Address.self, Geo.self, Company.self])
    }
}
