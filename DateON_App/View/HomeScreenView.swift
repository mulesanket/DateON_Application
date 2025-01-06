//
//  HomeScreenView.swift
//  DateON_App
//
//  Created by Sanket Mule on 02/01/25.
//

import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        VStack {
            Text("Welcome to DateON!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text("You have successfully logged in.")
                .font(.title2)
                .foregroundColor(.gray)
        }
        .padding()
    }
}
