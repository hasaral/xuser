//
//  DetailView.swift
//  xuser
//
//  Created by Hasan Saral on 2.07.2025.
//

import SwiftUI
import MapKit
import SwiftData

struct DetailView: View {
    let user: User
    @Environment(\.modelContext) var modelContext
    @State var isFavorite: Bool
    @State private var showSnackbar = false
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    VStack {
                        HStack {
                            Text("\(user.name)")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                            
                            Button() {
                                
                                addRemoveItem()
                                
                            } label: {
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .foregroundColor(isFavorite ? .red : .gray).opacity(isFavorite ? 1 : 0.5)
                                    .frame(width: 30, height: 30)
                            }
                            .padding()
                        }
                        Text("\(user.email)")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        Text("\(user.phone)")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        Text("\(user.website)")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        Text("\(user.address.street) ")
                        + Text("\(user.address.suite) ")
                        + Text("\(user.address.city) ")
                        
                        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(user.address.geo.lat) ?? 41.068496, longitude: Double(user.address.geo.lng) ?? 29.060419), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))), interactionModes: [])
                        
                            .cornerRadius(25.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                            .padding()
                        Spacer()
                    }
                    .frame(height: UIScreen.main.bounds.height-180)
                    .background(Color(.white))
                    .cornerRadius(22)
                    .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
                    .padding()
                    Spacer()
                }
            }
        }
        .overlay(
            VStack {
                if showSnackbar {
                    Snackbar(message: isFavorite ? "\(user.name) favorilere eklendi" : "\(user.name) favorilerden silindi")
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .animation(.easeInOut, value: showSnackbar)
                }
            }
                .padding(.bottom, 20),
            alignment: .bottom
        )
    }
    
    private func addRemoveItem() {
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showSnackbar = false
        }
        if isFavorite {
            do {
                let descriptor = FetchDescriptor<User>(
                    predicate: #Predicate { $0.id == user.id }
                )
                
                let users = try modelContext.fetch(descriptor)
                
                for user in users {
                    modelContext.delete(user)
                }
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        } else {
            do {
                let descriptor = FetchDescriptor<User>(
                    predicate: #Predicate { $0.id == user.id }
                )
                
                let existingUsers = try modelContext.fetch(descriptor)
                guard existingUsers.isEmpty else {
                    return
                }
                
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            modelContext.insert(user)
        }
        
        do {
            try modelContext.save()
            isFavorite.toggle()
            showSnackbar = true
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}


