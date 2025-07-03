//
//  FavoritesView.swift
//  xuser
//
//  Created by Hasan Saral on 2.07.2025.
//

import SwiftUI
import MapKit
import SwiftData

struct FavoritesView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showSnackbar = false
    @Query var favorites: [User]
    @State var name: String
    
    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    if favorites.isEmpty {
                        ContentUnavailableView("Kişileri favorilerine ekleyebilirsiniz.", systemImage: "pencil.and.scribble")
                    } else {
                        ForEach(favorites) { user in
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.5)) {
                                NavigationLink {
                                    DetailView(user: user, isFavorite: userExists(id: user.id, context: modelContext))
                                } label: {
                                    FavoritesListCell(user:user)
                                }
                            }
                        }.onDelete(perform: deleteItems)
                    }
                }
                .navigationTitle("Favori Kişiler")
            }
            .foregroundStyle(Color.accentColor)
        }
        .overlay(
            VStack {
                if showSnackbar {
                    Snackbar(message: "\(name) favorilerden silindi")
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .animation(.easeInOut, value: showSnackbar)
                }
            }
                .padding(.bottom, 20),
            alignment: .bottom
        )
    }
    
    func userExists(id: Int, context: ModelContext) -> Bool {
        let descriptor = FetchDescriptor<User>(
            predicate: #Predicate { $0.id == id }
        )
        return (try? context.fetch(descriptor).first != nil) ?? false
    }
    
    func getUserName(by id: Int, context: ModelContext) -> String? {
        let descriptor = FetchDescriptor<User>(
            predicate: #Predicate { $0.id == id }
        )

        do {
            if let user = try context.fetch(descriptor).first {
                return user.name
            } else {
                return nil
            }
        } catch {
            print("Hata: \(error)")
            return nil
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        let idS = offsets.map { favorites[$0].id }
        name = getUserName(by: idS[0], context: modelContext) ?? "-"
        showSnackbar = true
        withAnimation {
            DispatchQueue.global(qos: .userInteractive).async {
                offsets.map { favorites[$0] }.forEach(modelContext.delete)
                do {
                    try modelContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showSnackbar = false
            }
        }
    }
}

