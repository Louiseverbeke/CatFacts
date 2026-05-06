//
//  DetailView.swift
//  CatFacts
//
//  Created by Louise Verbeke on 06/05/2026.
//

import SwiftUI

struct DetailView: View {
    let catBreed: CatBreed
    
    var body: some View {
        Divider()
        
        VStack{
            LabeledContent("Country:", value: catBreed.breed)
            
            LabeledContent("Origin:", value: catBreed.origin)
            
            LabeledContent("Coat:", value: catBreed.coat)
            
            LabeledContent("Pattern:", value: catBreed.pattern)
            
            AsyncImage(url: URL(string: ImageURL.breedImages[catBreed.breed] ?? "")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 16)
                    
                } else if phase.error != nil {
                    Image(systemName: "rectangle.slash")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.secondary)
                        .fontWeight(.thin)
                        .frame(height: 200)
                    Text("Image Not Available")
                } else {
                    ProgressView()
                        .scaleEffect(4)
                        .tint(.red)
                }
            }
            
            Spacer()
        }
        .bold()
        .font(.title2)
        .padding()
        .navigationTitle(catBreed.breed)
    }
}

#Preview {
    NavigationStack {
        DetailView(catBreed: CatBreed(breed: "Burmese",
                                      country: "Burma & Thailand",
                                      origin: "Natural",
                                      coat: "Short",
                                      pattern: "solid"
                                     )
        )
    }
}
