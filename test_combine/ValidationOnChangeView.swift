//
//  ValidationOnChangeView.swift
//  test_combine
//
//  Created by Ilya Buldin on 09.02.2022.
//

import SwiftUI

class ValidationViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var message: String = ""
}

struct ValidationOnChangeView: View {
    @StateObject private var viewModel = ValidationViewModel()
    
    var body: some View {
        HStack {
            TextField("Your name", text: $viewModel.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: viewModel.name) { newValue in
                    viewModel.message = newValue.isEmpty ? "❌" : "✅"
                }
            Text(viewModel.message)
        }
        .padding()
    }
}

struct ValidationOnChangeView_Previews: PreviewProvider {
    static var previews: some View {
        ValidationOnChangeView()
    }
}
