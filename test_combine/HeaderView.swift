//
//  HeaderView.swift
//  test_combine
//
//  Created by Ilya Buldin on 08.02.2022.
//

import SwiftUI


struct HeaderView: View {
    var title: String = ""
    var subtitle: String = ""
    var description: String = ""
    
    
    var body: some View {
        VStack(spacing: 15) {
            if !title.isEmpty {
                Text(title)
                    .font(.largeTitle)
            }
            Text(subtitle)
                .foregroundColor(.gray)
            DescriptionView(description)
        }
    }
}


struct DescriptionView: View {
    
    var description: String = ""
    
    init(_ description: String) {
        self.description = description
    }
    
    var body: some View {
        Text(description)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
    }
}
