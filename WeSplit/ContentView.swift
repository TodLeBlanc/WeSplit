//
//  ContentView.swift
//  WeSplit
//
//  Created by Tod LeBlanc on 8/17/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let currency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    let tipPercentages = 0..<101
    
    // Paul's work inserts a var up top instead of in the individual section
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople+2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currency)
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                } header: {
                    Text("Total bill amount")
                        .frame(maxWidth: .infinity, alignment: .center)
                }

                Section {
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.wheel)
                } header: {
                    Text("How many people are in your party?")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            
                Section {
                    
//                        .frame(maxWidth: .infinity, alignment: .center)
                    Picker("What percentage to tip", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.automatic)
                } header: {
                    Text("How much would everyone like to tip?")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Section {
//                    Tod LeBlanc's code
//                    let tipAmount = checkAmount / 100 * Double(tipPercentage)
//                    let grandTotal = tipAmount + checkAmount
//                    let individualTotal = total / Double(numberOfPeople + 2)
                   
                    Text("Everyone owes: \(totalPerPerson, format: currency)")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("We Split") .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

