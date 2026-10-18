

import SwiftUI

struct AnimalRow: View {
  let animal: AnimalEntity

  var body: some View {
    HStack {
      AsyncImage(url: animal.picture) { image in
        image
          .resizable()
      } placeholder: {
        Image("rw-logo")
          .resizable()
          .overlay {
            if animal.picture != nil {
              ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.gray.opacity(0.4))
            }
          }
      }
      .aspectRatio(contentMode: .fit)
      .frame(width: 112, height: 112)
      .cornerRadius(8)

      VStack(alignment: .leading) {
        Text(animal.name)
          .multilineTextAlignment(.center)
          .font(.title3)
          
          Text(animal.animalBreedAndType)
              .font(.callout)
          
          if animal.animalDescription.count > 0 {
              Text(animal.animalDescription)
                  .lineLimit(2)
                  .font(.footnote)
          }
          
          HStack {
              Text(animal.getAgeDescription)
                  .modifier(AnimalAttributesCard(color: .pink))
              Text(animal.attributes?.sex ?? "N/A")
          }
      }
      .lineLimit(1)
    }
  }
}

struct AnimalRow_Previews: PreviewProvider {
  static var previews: some View {
      if let animal = Animal.mock.first {
          AnimalRow(animal: animal.toManagedObject()!)
    }
  }
}
