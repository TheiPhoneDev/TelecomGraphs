//
//  TelecommunicationsGraphsApp.swift
//  TelecommunicationsGraphs
//
//  Created by Pietro Gambatesa on 10/6/24.
//

import SwiftUI

@main
struct TelecommunicationsGraphsApp: App {
    
    @State var GraphData: [GraphsData] = []

    
    var body: some Scene {
        WindowGroup {
            ContentView(GraphData: GraphData)
        }
    }
}
