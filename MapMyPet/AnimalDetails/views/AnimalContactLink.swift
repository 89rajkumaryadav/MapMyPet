//
//  AnimalContactLink.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 15/09/26.
//

import SwiftUI

struct AnimalContactLink: View {
  let title: String
  let iconName: String
  let url: URL
  let color: Color

  var body: some View {
    Link(destination: url) {
      VStack(spacing: 4) {
        Image(systemName: iconName)
          .imageScale(.large)
        Text(title)
          .font(.callout)
      }
      .foregroundColor(color)
      .lineLimit(1)
      .minimumScaleFactor(0.1)
    }
    .padding(.vertical)
    .frame(maxWidth: .infinity)
    .background(color.opacity(0.1))
    .cornerRadius(8)
  }
}


#Preview {
    if let url = URL(string: "www.apple.com") {
      AnimalContactLink(
        title: "(555) 394-2033",
        iconName: "phone.fill",
        url: url,
        color: .green
      )
        .padding()
        
    }

}
