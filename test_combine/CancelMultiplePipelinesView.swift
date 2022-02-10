//
//  CancelMultiplePipelinesView.swift
//  test_combine
//
//  Created by Ilya Buldin on 10.02.2022.
//

import SwiftUI
import Combine

final class CancelMultiplePipelinesViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var nameValidation: String = ""
    
    @Published var surname: String = ""
    @Published var surnameValidation: String = ""
    private var cancelBag: Set<AnyCancellable> = []
    
    init() {
        $name
            .map {
                $0.isEmpty ? "❌" : "✅"
            }
            .sink { [unowned self] value in
                self.nameValidation = value
            }
            .store(in: &cancelBag)
        $surname
            .map {
                $0.isEmpty ? "❌" : "✅"
            }
            .sink { [unowned self] value in
                self.surnameValidation = value
            }
            .store(in: &cancelBag)
    }
    
    func cancelAll() {
        cancelBag.removeAll()
    }
}

struct CancelMultiplePipelinesView: View {
    @ObservedObject var viewModel = CancelMultiplePipelinesViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            HeaderView(title: "Cancel all pipelines",
                       subtitle: "Remove all",
                       description: "You learned earlier that you can cancel one pipeline by calling the cancel() function of the AnyCancellable. When everything is in a Set, an easy way to cancel all pipelines is to simply remove all of them from the Set")
            Group {
                HStack {
                    TextField("Your name", text: $viewModel.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text(viewModel.nameValidation)
                }
                HStack {
                    TextField("Your surname", text: $viewModel.surname)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text(viewModel.surnameValidation)
                }
            }
            .padding()
            Button("Cancel all pipelines") {
                viewModel.cancelAll()
            }
            
        }
        .font(.title)
    }
}

struct CancelMultiplePipelinesView_Previews: PreviewProvider {
    static var previews: some View {
        CancelMultiplePipelinesView()
    }
}

