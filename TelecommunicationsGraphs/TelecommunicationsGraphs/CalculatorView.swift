//
//  CalculatorView.swift
//  TelecommunicationsGraphs
//
//  Created by Pietro Gambatesa on 10/6/24.
//

import SwiftUI

struct CalculatorView: View {
    
    @State private var capacitor: String = ""
    @State private var resistor: String = ""
    @State private var Vi: String = ""
    @State private var Ft: String = ""
    @State private var F: String = ""

    
    @State private var result1: Double = 0.00
    @State private var result2: Double = 0.00
    @State private var result3: Double = 0.00
    @State private var result4: Double = 0.00
    @State private var result5: Double = 0.00
    @State private var result6: Double = 0.00
    
    let pi = 3.14
    let pi2 = 6.28
    
    @State private var present: Bool = false
    @State private var present1: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Form {
                        Section(header: Text(""), footer: Text("Remember to enter the correct units of measure. Make sure they conform to the SI system.")) {
                            TextField("Enter capacitor", text: $capacitor)
                            TextField("Enter resistor", text: $resistor)
                            TextField("Enter Vi", text: $Vi)
                            TextField("Enter f", text: $F)

                            
                           
                            
                            
                          
                            Text("Cuttoff Frequency: \(result3)")
                            
                            
                            Text("Attenuation: \(result4)")
                            
                            Text("Gain: \(result5)")
                            
                            Text("Output Voltage: \(result6)")
                            
                        }
                        Button {
                            calculation(Vi: Vi, C: capacitor, R: resistor, F: F)
                        } label: {
                            Text("Calculate")
                        }.frame(maxWidth: .infinity, alignment: .center)
                        
                        Button {
                            self.present.toggle()
                        } label: {
                            Text("Calculate capacitor")
                        }.frame(maxWidth: .infinity, alignment: .center)
                            .sheet(isPresented: $present, content: {
                                CalculateCapacitorView()
                            })
                        
                        Button {
                            self.present1.toggle()
                        } label: {
                            Text("Calculate resistor")
                        }.frame(maxWidth: .infinity, alignment: .center)
                            .sheet(isPresented: $present1, content: {
                                CalculateResistorView()
                            })
                        
                        

                        
                    }.keyboardType(.numberPad)
                }
            }.navigationTitle("Calculator")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
     func calculation(Vi: String, C: String, R: String, F: String) {
        if let validVi = Double(Vi), let validC = Double(C), let validR = Double(R), let validF = Double(F) {

            result3 = 1/(pi2*validR*validC)
            result4 = validVi/1.414
            result5 = 1/sqrt(1+(pi2*validF*validR*validC)*(pi2*validF*validR*validC))
            result6 = validVi*result5
            
        } else {
            print("Error: One of the values could not be converted to Double")
        }
    }
    
}

struct CalculateCapacitorView: View {
    @State private var resistor: String = ""
    @State private var Ft: String = ""
    let pi = 3.14
    let pi2 = 6.28
    @State private var result: Double = 0.00
    
    func copy(pasteboard: String) {
        UIPasteboard.general.string = pasteboard
    }

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Form {
                        TextField("Resistor", text: $resistor)
                        TextField("Frequency", text: $Ft)
                        Text("Capacitor: \(result)")
                        Button {
                            calculation(R: resistor, Ft: Ft)
                        } label: {
                            Text("Calculate")
                        }.frame(maxWidth: .infinity, alignment: .center)
                        Button {
                            copy(pasteboard: "\(result)")
                        } label: {
                            Text("Copy")
                        }.frame(maxWidth: .infinity, alignment: .center)
                    }.keyboardType(.numberPad)
                }
            }.navigationTitle("Calculate capacitor")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing, content: {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Done")
                        }
                    })
                })
        }
    }
    
    func calculation(R: String, Ft: String) {
        if let validR = Double(R), let validFt = Double(Ft) {
            
            result = 1/(pi2*validR*validFt)
            
        } else {
            print("Error: One of the values could not be converted to Double")
        }
    }
    
    
    
}

struct CalculateResistorView: View {
    @State private var capacitor: String = ""
    @State private var Ft: String = ""
    let pi = 3.14
    let pi2 = 6.28
    @State private var result: Double = 0.00

    func copy(pasteboard: String) {
        UIPasteboard.general.string = pasteboard
    }
    
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Form {
                        TextField("Capacitor", text: $capacitor)
                        TextField("Frequency", text: $Ft)
                        Text("Capacitor: \(result)")
                        Button {
                            calculation(C: capacitor, Ft: Ft)
                        } label: {
                            Text("Calculate")
                        }.frame(maxWidth: .infinity, alignment: .center)
                        Button {
                            copy(pasteboard: "\(result)")
                        } label: {
                            Text("Copy")
                        }.frame(maxWidth: .infinity, alignment: .center)
                    }.keyboardType(.numberPad)
                }
            }.navigationTitle("Calculate resistor")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing, content: {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Done")
                        }
                    })
                })
        }
    }
    
    func calculation(C: String, Ft: String) {
        if let validC = Double(C), let validFt = Double(Ft) {
            
            result = 1/(pi2*validC*validFt)
            
        } else {
            print("Error: One of the values could not be converted to Double")
        }
    }
    
}

#Preview {
    CalculatorView()
}
