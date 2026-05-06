//
//  FactView.swift
//  CatFacts
//
//  Created by Louise Verbeke on 06/05/2026.
//

import SwiftUI

struct FactView: View {
    @State private var factVM = FactViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("🐈 Cat Fact")
                .font(Font.system(size: 42))
                .bold()
            Text(factVM.fact)
                .font(.title2)
            
            Button("Dismiss") {
                dismiss()
            }
            .buttonStyle(.glassProminent)
            .font(.title2)
        }
        .padding()
        .task {
            await factVM.getData()
        }
    }
}

#Preview {
    FactView()
}
