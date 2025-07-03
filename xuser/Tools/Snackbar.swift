//
//  Snackbar.swift
//  xuser
//
//  Created by Hasan Saral on 3.07.2025.
//


import SwiftUI

struct Snackbar: View {
    var message: String
 

    var body: some View {
        HStack {
            Text(message)
                .foregroundColor(.white)
                .padding(.horizontal)
 
        }
        .padding()
        .background(Color.green.opacity(0.8))
        .cornerRadius(8)
        .shadow(radius: 4)
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.easeInOut, value: UUID())
    }
}
