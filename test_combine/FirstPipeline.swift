//
//  FirstPipeline.swift
//  test_combine
//
//  Created by Ilya Buldin on 10.02.2022.
//

import SwiftUI

final class FirstPipelineViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var validation: String = ""
    
    
    init() {
        print("In init")
        $name
            .map {
                $0.isEmpty ? "❌" : "✅"
            }
            .assign(to: &$validation)
    }
}

struct FirstPipeline: View {
    @ObservedObject private var viewModel = FirstPipelineViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            HeaderView(title: "First Pipeline",
                       subtitle: "Introduction",
                       description: "This is a simple pipeline you can create in Combine to validate a text field.")
            HStack {
                TextField("name", text: $viewModel.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(viewModel.validation)
            }
            .padding()
            
        }
        .font(.title)
    }
}

struct FirstPipeline_Previews: PreviewProvider {
    static var previews: some View {
        FirstPipeline()
    }
}
