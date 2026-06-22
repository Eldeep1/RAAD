//
//  HourSelectorView.swift
//  RAAD
//
//  Created by depo on 22/06/2026.
//

import SwiftUI

struct HourSelectorView: View {

    let hours: [HourlyForecastModel]

    @Binding var selectedHour: HourlyForecastModel?

    var body: some View {

        ScrollView(.horizontal, showsIndicators: false) {

            HStack(spacing: 12) {

                ForEach(hours) { hour in

                    HourCard(
                        hour: hour,
                        isSelected: selectedHour?.id == hour.id
                    )
                    .onTapGesture {

                        selectedHour = hour
                    }
                }
            }
        }
    }
}
