//
//  WeatherSWidgetBundle.swift
//  WeatherSWidget
//
//  Created by Sasidurka on 2024-12-16.
//

import WidgetKit
import SwiftUI

@main
struct WeatherSWidgetBundle: WidgetBundle {
    var body: some Widget {
        WeatherSWidget()
        WeatherSWidgetControl()
        WeatherSWidgetLiveActivity()
    }
}
