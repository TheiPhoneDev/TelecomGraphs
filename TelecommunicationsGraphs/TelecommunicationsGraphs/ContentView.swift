//
//  ContentView.swift
//  TelecommunicationsGraphs
//
//  Created by Pietro Gambatesa on 10/6/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var GraphData: [GraphsData] = []

    
    var body: some View {
        TabView {
            GraphView(GraphData: GraphData)
                .tabItem({
                    Label("Charts", systemImage: "chart.xyaxis.line")
                })
            CalculatorView()
                .tabItem({
                    Label("Calculator", systemImage: "x.squareroot")
                })
        }
    }
}

#Preview {
    ContentView()
}
