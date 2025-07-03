//
//  MainView.swift
//  xuser
//
//  Created by Hasan Saral on 2.07.2025.
//

import SwiftUI
import MapKit
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) var modelContext
    @StateObject private var mainViewModel = MainViewViewModel()
    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    if mainViewModel.dataManager.dataModel.isEmpty {
                        ContentUnavailableView("Erken kalkan yol alır", systemImage: "pencil.and.scribble")
                    } else {
                        ForEach(mainViewModel.userModel) { user in
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.5)) {
                                NavigationLink {
                                    DetailView(user: user, isFavorite: userExists(id: user.id, context: modelContext))
                                } label: {
                                    TaskListCell(user:user, isFavorite: userExists(id: user.id, context: modelContext))
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Users")
            }
            .foregroundStyle(Color.accentColor)
        }
        .onAppear {
             mainViewModel.getUsers()
        }
    }
    
    func userExists(id: Int, context: ModelContext) -> Bool {
        let descriptor = FetchDescriptor<User>(
            predicate: #Predicate { $0.id == id }
        )
        return (try? context.fetch(descriptor).first != nil) ?? false
    }
}

#Preview {
    MainView()
}
