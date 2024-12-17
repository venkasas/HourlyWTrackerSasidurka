//
//  WeatherSWidgetLiveActivity.swift
//  WeatherSWidget
//
//  Created by Sasidurka on 2024-12-16.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WeatherSWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WeatherSWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WeatherSWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension WeatherSWidgetAttributes {
    fileprivate static var preview: WeatherSWidgetAttributes {
        WeatherSWidgetAttributes(name: "World")
    }
}

extension WeatherSWidgetAttributes.ContentState {
    fileprivate static var smiley: WeatherSWidgetAttributes.ContentState {
        WeatherSWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WeatherSWidgetAttributes.ContentState {
         WeatherSWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WeatherSWidgetAttributes.preview) {
   WeatherSWidgetLiveActivity()
} contentStates: {
    WeatherSWidgetAttributes.ContentState.smiley
    WeatherSWidgetAttributes.ContentState.starEyes
}
