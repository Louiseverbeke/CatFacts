//
//  ListView.swift
//  CatFacts
//
//  Created by Louise Verbeke on 05/05/2026.
//

import SwiftUI

struct ListView: View {
    @State private var catVM = CatViewModel()
    @State private var sheetIsPresented = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(catVM.catBreeds) { catBreed in
                    NavigationLink {
                        DetailView(catBreed: catBreed)
                    } label: {
                        Text(catBreed.breed)
                            .font(.title2)
                    }
                    .task {
                        await catVM.loadNextIfNeeded(catBreed: catBreed)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Cat Breeds:")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            sheetIsPresented.toggle()
                        } label: {
                            Text("🐈")
                            Image(systemName: "lightbulb.fill")
                        }
                        .buttonStyle(.bordered)
                    }
                    
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button("Load All", systemImage: "tray.and.arrow.down.fill") {
                            Task {
                                await catVM.loadAll()
                            }
                        }
                        
                        HStack {
                            Spacer()
                            
                            Text("\(catVM.catBreeds.count) of \(catVM.total)breeds")
                            
                            Spacer()
                        }
                    }
                }
                
                if catVM.isLoading {
                    ProgressView()
                        .scaleEffect(4)
                        .tint(.red)
                }
            }
        }
        .task {
            await catVM.getData()
        }
        .sheet(isPresented: $sheetIsPresented) {
            FactView()
                .presentationDetents([.medium])
                .presentationBackground(Color(.systemBackground))
        }
    }
}

#Preview {
    ListView()
}
