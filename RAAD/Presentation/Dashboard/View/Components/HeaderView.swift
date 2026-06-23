//
//  HeaderView.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import SwiftUI

struct HeaderView: View {

    var body: some View {
        HStack {
            Text("RAAD")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.cyan)

            Spacer()
        }
        .padding(.horizontal)
    }
}
