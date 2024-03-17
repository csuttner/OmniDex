//
//  ImageCreationView.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/17/24.
//

import SwiftUI

struct ImageCreationView: View {
    @Environment(ServiceProvider.self) private var serviceProvider
    @Environment(ImageCreation.self) private var creation
    
    @State private var pickerSelection: ImageCreationType = .generation
    @State private var prompt = ""
    @State private var image: UIImage?
    @State private var alertItem = AlertItem()
    
    var body: some View {
        VStack(spacing: 16) {
            Picker("", selection: $pickerSelection) {
                ForEach(ImageCreationType.allCases) { creationType in
                    Text(creationType.rawValue).tag(creationType)
                }
            }
            .pickerStyle(.segmented)
            
            TextField("", text: $prompt)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    Task {
                        await generateImage()
                    }
                }
            
            Group {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                } else {
                    ContentUnavailableView(
                        "Your image will appear here",
                        systemImage: "photo"
                    )
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .border(.secondary)
            
            Spacer()
        }
        .padding(16)
        .alert(item: $alertItem)
    }
    
    func generateImage() async {
        do {
            let imageData = try await serviceProvider.imageService
                .fetchImageGeneration(prompt: prompt)

            image = UIImage(data: imageData)
            
        } catch {
            alertItem = AlertItem(error: error)
        }
    }
}

#Preview {
    ImageCreationView()
        .environment(Mock.imageCreation)
}
