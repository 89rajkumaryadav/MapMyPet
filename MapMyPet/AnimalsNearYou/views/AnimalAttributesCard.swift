//
//  AnimalAttributesCard.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 11/10/26.
//

import SwiftUI

struct AnimalAttributesCard: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .padding(4)
            .background(color.opacity(0.2))
            .cornerRadius(8)
            .foregroundColor(color)
            .font(.subheadline)
    }
}

#Preview {
    Text("Attributes")
        .modifier(AnimalAttributesCard(color: .gray))
        .padding()
}
