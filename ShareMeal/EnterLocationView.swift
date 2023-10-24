//
//  EnterLocationView.swift
//  ShareMeal
//
//  Created by Eric on 23/10/2023.
//

import SwiftUI

struct EnterLocationView: View {
    @State private var postCode = "SW1 1AA"
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome")
                    .font(.largeTitle)
                
                Text("To get started, please tell us your post code.")
                
                HStack {
                    TextField("Your post code", text: $postCode)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: 200)
                    
                    NavigationLink("Go") {
                        SelectFoodbankView(postCode: postCode)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

#Preview {
    EnterLocationView()
}
