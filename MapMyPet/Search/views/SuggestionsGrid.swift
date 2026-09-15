//
//  SuggestionsGrid.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 15/09/26.
//

import SwiftUI

struct SuggestionsGrid: View {
    @Environment(\.isSearching) var isSearching: Bool
    
    let suggestions: [AnimalSearchType]
    var action: (AnimalSearchType) -> Void
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .leading){
           Text("Browse by type")
                .font(.title2.bold())
            LazyVGrid(columns: columns) {
                ForEach(AnimalSearchType.suggestions, id: \.self) { suggestion in
                    Button{
                        action(suggestion)
                    } label: {
                     AnimalTypeSuggestionView(suggestion: suggestion)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.horizontal)
        .opacity(isSearching ? 0 : 1)
    }
}

#Preview {
    SuggestionsGrid(suggestions: AnimalSearchType.suggestions){_ in }
}
