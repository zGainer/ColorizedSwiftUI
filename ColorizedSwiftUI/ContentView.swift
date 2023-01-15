//
//  ContentView.swift
//  ColorizedSwiftUI
//
//  Created by Eugene on 13.01.23.
//

import SwiftUI

enum Field: Hashable {
    case redTextField, greenTextField, blueTextField
}

struct ContentView: View {
    
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    @State private var redTFValue = ""
    @State private var greenTFValue = ""
    @State private var blueTFValue = ""
    
    @FocusState private var focusedField: Field?

    var body: some View {
        ZStack {
            Color(.systemIndigo)
                .ignoresSafeArea()
            
            VStack {
                PreviewView(color: Color(red: CGFloat(redSliderValue / 255),
                                         green: CGFloat(greenSliderValue / 255),
                                         blue: CGFloat(blueSliderValue / 255)))
                
                Spacer()
                    .frame(height: 40)
                
                SelectView(textFieldColor: .redTextField,
                           sliderColor: .red,
                           focusedField: $focusedField,
                           textFieldValue: $redTFValue,
                           sliderValue: $redSliderValue)
                
                SelectView(textFieldColor: .greenTextField,
                           sliderColor: .green,
                           focusedField: $focusedField,
                           textFieldValue: $greenTFValue,
                           sliderValue: $greenSliderValue)
                
                SelectView(textFieldColor: .blueTextField,
                           sliderColor: .blue,
                           focusedField: $focusedField,
                           textFieldValue: $blueTFValue,
                           sliderValue: $blueSliderValue)
                       
                Spacer()
            }
            .padding()
        }
    }
}

struct SelectView: View {
    let textFieldColor: Field
    let sliderColor: Color

    var focusedField: FocusState<Field?>.Binding
    
    @State private var alertPresented = false

    @Binding var textFieldValue: String
    @Binding var sliderValue: Double

    @FocusState private var isInputActive: Bool

    var body: some View {
        HStack {
            SelectColorView(tintColor: sliderColor, sliderValue: $sliderValue)
            
            EnterColorView(textFieldValue: $textFieldValue)
                .focused($isInputActive)
                .focused(focusedField, equals: textFieldColor)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        if isInputActive {
                            Button(action: {
                                checkValue()
                                nextTextField(reverse: true)
                                setSliderValue()
                            },
                                   label: { Image(systemName: "chevron.up") })
                            
                            Button(action: {
                                checkValue()
                                nextTextField()
                                setSliderValue()
                            },
                                   label: { Image(systemName: "chevron.down") })
                            
                            Spacer()
                            
                            Button("Done") {
                                checkValue()
                                setSliderValue()
                                isInputActive = false
                            }
                        }
                    }
                }
                .onAppear() {
                    textFieldValue = "\(lround(sliderValue))"
                }
                .onChange(of: sliderValue) { newValue in
                    textFieldValue = "\(lround(newValue))"
                }
                .alert("Error number", isPresented: $alertPresented, actions: {}) {
                    Text("Enter value from 0 to 255")
                }
        }
    }
    
    private func setSliderValue() {
        sliderValue = Double(textFieldValue) ?? sliderValue
    }
}

extension SelectView {
    
    private func checkValue() {
        if let value = Double(textFieldValue) {
            if value > 255 {
                textFieldValue = "0"
                alertPresented = true
            }
        } else {
            textFieldValue = "0"
        }
    }
    
    private func nextTextField(reverse: Bool = false) {
        
        switch textFieldColor {
        case .redTextField:
            focusedField.wrappedValue = reverse ? .blueTextField : .greenTextField
        case .greenTextField:
            focusedField.wrappedValue = reverse ? .redTextField : .blueTextField
        case .blueTextField:
            focusedField.wrappedValue = reverse ? .greenTextField : .redTextField
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
