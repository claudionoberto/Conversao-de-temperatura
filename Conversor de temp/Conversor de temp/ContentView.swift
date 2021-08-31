//
//  ContentView.swift
//  Conversor de temp
//
//  Created by Claudio Noberto  on 25/08/21.
//

import SwiftUI

struct ContentView: View {
    @State private var pickerInput = 1
    @State private var pickerOutput = 1
    @State private var tempInput = ""
    @State private var tempOutput = ""
    func convert(temperature: String, from inputUnit: UnitTemperature, to outputUnit: UnitTemperature) -> String? {
        let inputFormatter = NumberFormatter()
        guard let value = inputFormatter.number(from: temperature) else { return nil }

        let inputTemp = Measurement(value: value.doubleValue, unit: inputUnit)
        let outputTemp = inputTemp.converted(to: outputUnit)

        let outputformatter = MeasurementFormatter()
        outputformatter.unitOptions = .providedUnit
        return outputformatter.string(from: outputTemp)
    }
    
    let tempInpu: [UnitTemperature] = [.celsius,.fahrenheit,.kelvin]
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Selecione a unidade da temperatura")){
                    Picker("input temp", selection: $pickerInput){
                        ForEach(0..<tempInpu.count){
                            Text("\(self.tempInpu[$0].symbol)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    TextField("Informe a temperatura", text: $tempInput)
                }
                
                Section(header: Text("Converter para:")){
                    Picker("output temp", selection: $pickerOutput){
                        ForEach(0..<tempInpu.count){
                            Text("\(self.tempInpu[$0].symbol)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                }
                
                Section(header: Text("Resultado:")) {
                    Text(convert(temperature: tempInput, from: tempInpu[pickerInput],
                                to: tempInpu[pickerOutput]) ?? "")
                    
                }
                
            }
            
            .navigationTitle("Conversor de Temp")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
