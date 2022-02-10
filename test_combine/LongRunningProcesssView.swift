//
//  LongRunningProcessViewModel.swift
//  test_combine
//
//  Created by Ilya Buldin on 10.02.2022.
//

import SwiftUI
import Combine

final class LongRunningProcessViewModel: ObservableObject {
    @Published var data: String = ""
    @Published var status: String = ""
    
    private var calcellablePipeline: AnyCancellable?
    
    init() {
        data = "Initial data"
        calcellablePipeline = $data
            .map { [unowned self] value -> String in
                status = "Processing..."
                return value
            }
            .delay(for: 5, scheduler: RunLoop.main)
            .sink(receiveValue: { [unowned self] value in
                status = "Finished process"
            })
        
    }
    
    func refreshData() {
        data = "Refreshed data"
    }
    
    func cancel() {
        status = "Cancelled"
        calcellablePipeline?.cancel()
        calcellablePipeline = nil
    }
}

struct LongRunningProcessView: View {
    @ObservedObject var viewModel = LongRunningProcessViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            HeaderView(title: "Cancellable Pipeline",
                       subtitle: "Long-Running Process",
                       description: "In this example we pretend we have a long-running process that we can cancel before it finishes")
            Text(viewModel.data)
            Button("Refresh data") {
                viewModel.refreshData()
            }
            Button("Cancel subscriprion") {
                viewModel.cancel()
            }
            .opacity(viewModel.status == "Processing..." ? 1 : 0)
            Text(viewModel.status)
        }
        .font(.title)
    }
}

struct LongRunningProcessView_Previews: PreviewProvider {
    static var previews: some View {
        LongRunningProcessView()
    }
}
