//
//  ContentView.swift
//  test_combine
//
//  Created by Ilya Buldin on 08.02.2022.
//

import SwiftUI


class ViewModel: ObservableObject {
    @Published var state = "First state"
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.state = "Second state"
        }
    }
    
}

struct ContentView: View {
    @ObservedObject private var viewModel = ViewModel()
    
    var body: some View {
        Text(viewModel.state)
            .font(.largeTitle)
            .animation(.easeOut)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
