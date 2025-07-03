//
//  TaskListCell.swift
//  xuser
//
//  Created by Hasan Saral on 2.07.2025.
//


import SwiftUI


struct TaskListCell: View {
    let user: User
    var isFavorite: Bool
    
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
                .foregroundColor(isFavorite ? .red : .clear).opacity(isFavorite ? 1 : 0.5)
        }
        .padding()
    }
}

struct CircularView: View {
    var value: CGFloat = 0.5
    var lineWidth: Double = 6
    var isColor: Bool = false
    
    @State var appear = false
    
    var body: some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            .fill(.angularGradient(colors:[.random()], center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
            .onAppear {
                if !appear {
                    withAnimation(.spring().delay(0.5)) {
                        appear = true
                    }
                }
            }
            .onDisappear {
                appear = false
            }
    }
}

