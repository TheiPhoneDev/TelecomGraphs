//
//  GraphView.swift
//  TelecommunicationsGraphs
//
//  Created by Pietro Gambatesa on 10/6/24.
//

import SwiftUI
import Charts

struct GraphView: View {
    
    @State private var presentAddDataSheet: Bool = false
    @State var GraphData: [GraphsData] = []
    @State var valori: [Double] = []

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if GraphData.isEmpty {
                        Text("Insert data to generate graph")
                            .foregroundColor(.secondary)
                    } else {
                        Chart(GraphData) { data in
                            LineMark(
                                x: .value("x", 0),
                                y: .value("y", data.Vi)
                            ).symbol(.circle)
                                .interpolationMethod(.catmullRom)

                            LineMark(
                                x: .value("x", data.Ft),
                                y: .value("y", data.Vo)
                            ).symbol(.circle)
                                .interpolationMethod(.catmullRom)
                           
                            LineMark(
                                x: .value("x", data.Ft),
                                y: .value("y", data.Vi/data.Vo)
                            ).symbol(.circle)
                                .interpolationMethod(.catmullRom)
                            
                            
                        }.chartXAxis {
                            AxisMarks(values: valori)
                        }
                        .chartYAxis {
                            AxisMarks(position: .leading)
                        }
                        .frame(height: 360)
                        .padding()
                    }
                }
            }.navigationTitle("Graph")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing, content: {
                        Button {
                            self.presentAddDataSheet.toggle()
                            self.GraphData.removeAll()
                        } label: {
                            Text("Add data")
                        }.sheet(isPresented: $presentAddDataSheet, content: {
                            AddDataSheetView(GraphData: $GraphData, valueData: values, valori: $valori)
                        })
                    })
                })
        }
    }
}

struct AddDataSheetView: View {
    
    @Binding var GraphData: [GraphsData]
    
    
    @State private var Vi: String = ""
    @State private var Vo: String = ""
    @State private var Ft: String = ""
    @State private var maxValue: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @State var valueData: [MaxValues] = []
    @Binding var valori: [Double]

    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Form {
                        TextField("Enter Vi", text: $Vi)
                        TextField("Enter Vo", text: $Vo)
                        TextField("Enter Ft", text: $Ft)
                        
                        
                        ForEach(valueData) { value in
                            Button {
                                valori.append(value.value)
                            } label: {
                                Text("\(value.value)")
                            }
                        }
                        
                        Button {
                            addData(Vi: Vi, Vo: Vo, Ft: Ft)
                            debugPrint(GraphData)
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Add data")
                                .font(.title3.weight(.semibold))
                                .padding(10)
                        }.buttonStyle(.borderedProminent)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .listRowBackground(Color(colorScheme == .dark ? .black : .systemGray6))
                            .listRowSeparator(.hidden)
                    }
                    
                }
            }.navigationTitle("Add data")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                    }
                })
        }
    }
    
  
    
    func addData(Vi: String, Vo: String, Ft: String) {
        if let validVi = Double(Vi), let validVo = Double(Vo), let validFt = Double(Ft) {
            GraphData.append(GraphsData(Vi: validVi, Vo: validVo, Ft: validFt))
        } else {
            print("Error: One of the values could not be converted to Double")
        }
    }
    
}

struct GraphsData: Identifiable {
    var id = UUID()
    var Vi: Double
    var Vo: Double
    var Ft: Double
}

struct MaxValues: Identifiable {
    var id = UUID()
    var value: Double
}

let values = [
    MaxValues(value: 0),
    MaxValues(value: 100),
    MaxValues(value: 200),
    MaxValues(value: 300),
    MaxValues(value: 400),
    MaxValues(value: 500),
    MaxValues(value: 600),
    MaxValues(value: 700),
    MaxValues(value: 800),
    MaxValues(value: 900),
    MaxValues(value: 1000),
    MaxValues(value: 1100),
    

]

#Preview {
    GraphView()
}
