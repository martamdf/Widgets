//
//  DBDynamicIslandLiveActivity.swift
//  DBDynamicIsland
//
//  Created by Marta Maquedano on 7/4/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

@main
struct DBDynamicIslandLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: StatusAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("\(context.state.name) healing until:")
                Text("\(context.state.estimatedHour, style: .timer)").multilineTextAlignment(.center)
            
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)
            
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    ZStack{
                        ContainerRelativeShape()
                            .fill(.white)
                        Image(context.state.image)
                            .resizable()
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: 50)
                    .clipShape(Capsule())
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.estimatedHour, style: .timer)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("\(context.state.name) is healing.")
                }
            } compactLeading: {
                ZStack{
                    Circle().fill(Color.white)
                    Image(context.state.image)
                        .resizable()
                        .clipShape(Circle())
                }
                .aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: 40)
                
            } compactTrailing: {
                Text(context.state.estimatedHour, style: .timer)
                    .frame(maxWidth: 46)
                
            } minimal: {
                ZStack{
                    Circle().fill(Color.white)
                    Image(context.state.image)
                        .resizable()
                        .clipShape(Circle())
                }
                .aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: 40)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension StatusAttributes {
    fileprivate static var preview: StatusAttributes {
        StatusAttributes()
    }
}

extension StatusAttributes.ContentState {
    fileprivate static var goku: StatusAttributes.ContentState {
        StatusAttributes.ContentState(name: "Goku",
                                      estimatedHour: Date()+3600,
                                      image: "GokuAvatar",
                                      hp: 10)
    }
}

#Preview("Notification", as: .content, using: StatusAttributes.preview) {
    DBDynamicIslandLiveActivity()
} contentStates: {
    StatusAttributes.ContentState.goku
}
