//
//  EditProfileView.swift
//  OmniDex
//
//  Created by Clay Suttner on 3/9/24.
//

import SwiftUI
import UIKit

struct EditProfileView: View {
    @Environment(StoreProvider.self) private var storeProvider
    @Environment(\.dismiss) private var dismiss
    
    @State private var user: User?
    @State private var alertItem = AlertItem()
    @State private var selectedImage: UIImage?
    @State private var willUseCamera = true
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Spacer()

                Button(Constants.Common.done) {
                    dismiss()
                }
                .fontWeight(.semibold)
                .padding(.trailing, 12)
            }
            
            Group{
                if let selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .overlay(
                            Circle()
                                .stroke(Color.accentColor, lineWidth: 6)
                        )
                        .clipShape(.circle)
                    
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .foregroundStyle(.gray.opacity(0.5))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(contentMode: .fit)
            .padding(.horizontal, 24)
            
            ImagePickerMenu(
                selectedImage: $selectedImage
            ) {
                Text(Constants.Common.edit)
                    .fontWeight(.medium)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 6)
                    .background(.gray.opacity(0.5))
                    .foregroundStyle(Color.primary)
                    .clipShape(.capsule)
            }
            
            Spacer()
        }
        .alert(item: $alertItem)
        .task {
            await fetchUser()
            loadUserInfo()
        }
        .task(id: selectedImage) {
            await saveUser()
        }
    }
    
    private func fetchUser() async {
        do {
            user = try await storeProvider.userStore.fetchUser()
        } catch {
            alertItem = AlertItem(error: error)
        }
    }
    
    private func loadUserInfo() {
        if
            let user,
            let imageData = user.image,
            let uiImage = UIImage(data: imageData) {
            selectedImage = uiImage
        }
    }
    
    private func saveUser() async {
        do {
            let user = user ?? User()

            user.image = selectedImage?.pngData()
            
            try await storeProvider.userStore.save(user: user)

        } catch {
            alertItem = AlertItem(error: error)
        }
    }
}

#Preview {
    EditProfileView()
        .environment(Mock.storeProvider)
}
