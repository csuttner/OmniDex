//
//  ImagineView.swift
//  OmniDex
//
//  Created by Clay Suttner on 2/26/24.
//

import SwiftUI

struct ImagineRootConfig {
    var path = [ImageCreation]()
}

struct ImagineRootView: View {
    @Environment(StoreProvider.self) private var storeProvider
    
    @Binding var tab: Tab
    
    @State private var creations = [ImageCreation]()
    @State private var config = ImagineRootConfig()
    @State private var alertItem = AlertItem()
    
    var body: some View {
        NavigationStack(path: $config.path) {
            VStack {
                ImagineRootContentView(creations: creations)
                
                TabBar(tab: $tab)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "rectangle.stack.badge.plus") {
                        config.path.append(ImageCreation())
                    }
                }
            }
            .navigationTitle(Constants.Tabs.imagine)
            .navigationDestination(for: ImageCreation.self) { creation in
                ImageCreationView()
                    .environment(creation)
            }
            .alert(item: $alertItem)
            .task(id: config.path) {
                if config.path.isEmpty {
                    await loadStoredCreations()
                }
            }
        }
    }
    
    private func loadStoredCreations() async {
        do {
            creations = try await storeProvider
                .imageCreationStore.fetchCreations()

        } catch {
            alertItem = AlertItem(error: error)
        }
    }
    
    private func delete(creations: [ImageCreation]) async {
        do {
            try await storeProvider.imageCreationStore
                .delete(creations: creations)
            
        } catch {
            alertItem = AlertItem(error: error)
        }
    }
}

#Preview {
    ImagineRootView(tab: .constant(.imagine))
        .environment(Mock.storeProvider)
        .environment(Mock.serviceProvider)
}
