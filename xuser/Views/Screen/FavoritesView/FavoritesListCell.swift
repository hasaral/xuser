//
//  TaskListCell.swift
//  xuser
//
//  Created by Hasan Saral on 3.07.2025.
//

import SwiftUI

struct FavoritesListCell: View {
    let user: User
    
    var body: some View {
        HStack() {
            Text("\(user.name.description.first ?? "-")")
                .frame(width: 40, height: 40)
                .background(Color(UIColor.systemBackground).opacity(0.3))
                .overlay(CircularView(value:1, isColor: true))
            Spacer()
            VStack(spacing: 8) {
                Text(user.name)
                    .foregroundStyle(.secondary)
                    .padding(.top, -10)
                
                Text(user.email)
                    .font(.caption.weight(.light))
                    .lineLimit(1)
            }
            Spacer()
            Image(systemName: "heart.fill")
                .foregroundColor(.red).opacity(1)
        }
        .padding()
    }
}
