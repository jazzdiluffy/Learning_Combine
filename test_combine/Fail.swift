//
//  Fail.swift
//  test_combine
//
//  Created by Ilya Buldin on 14.02.2022.
//

import SwiftUI
import Combine

struct FailView: View {
    @ObservedObject private var viewModel = FailViewModel()
    @State private var age: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            HeaderView(title: "Fail",
                       subtitle: "Introduction",
                       description: "The Fail Publisher will simply publish a failure with your error and close your pipeline")
            TextField("Enter Age", text: $age)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button("Save") {
                viewModel.save(age: Int(age) ?? -1)
            }
            Text("\(viewModel.age)")
        }
        .font(.title)
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Invalid Age"), message: Text(error.rawValue))
        }
    }
}

final class FailViewModel: ObservableObject {
    @Published var age = 0
    @Published var error: InvalidAgeError?
    private var cancelBag: Set<AnyCancellable> = []
    
    func save(age: Int) {
        Validators.validAgePublisher(age: age)
            .sink(receiveCompletion: { [unowned self] completion in
                if case .failure(let error) = completion {
                    self.error = error
                }
            }, receiveValue: { [unowned self] newAgeValue in
                self.age = newAgeValue
            })
            .store(in: &cancelBag)
    }
}

final class Validators {
    static func validAgePublisher(age: Int) -> AnyPublisher<Int, InvalidAgeError> {
        
        if age < 0 {
            return Fail(error: InvalidAgeError.lessThanZero)
                .eraseToAnyPublisher()
        } else if age > 100 {
            return Fail(error: InvalidAgeError.moreThanOneHundred)
                .eraseToAnyPublisher()
        }
        
        return Just(age)
            .setFailureType(to: InvalidAgeError.self)
            .eraseToAnyPublisher()
    }
}

enum InvalidAgeError: Error, Identifiable {
    var id: Self { self }
    case lessThanZero
    case moreThanOneHundred
    var rawValue: String {
        switch self {
        case .lessThanZero:
            return "lessThanZero"
        case .moreThanOneHundred:
            return "moreThanOneHundred"
        }
        
    }
}

struct FailView_Previews: PreviewProvider {
    static var previews: some View {
        FailView()
    }
}


