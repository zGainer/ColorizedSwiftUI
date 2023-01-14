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
            Color(.darkGray)
                .ignoresSafeArea()
            
            VStack {
                PreviewView(color: Color(red: CGFloat(redSliderValue / 255),
                                         green: CGFloat(greenSliderValue / 255),
                                         blue: CGFloat(blueSliderValue / 255)))
                
                SelectView(textFieldColor: .redTextField,
                           sliderColor: .red,
                           textFieldValue: $redTFValue,
                           sliderValue: $redSliderValue)
                
                SelectView(textFieldColor: .greenTextField,
                           sliderColor: .green,
                           textFieldValue: $greenTFValue,
                           sliderValue: $greenSliderValue)
                
                SelectView(textFieldColor: .blueTextField,
                           sliderColor: .blue,
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
    
    @Binding var textFieldValue: String
    @Binding var sliderValue: Double
    
    var body: some View {
        HStack {
            SelectColorView(tintColor: sliderColor, sliderValue: $sliderValue)
            
            EnterColorView(textFieldColor: textFieldColor,
                           textFieldValue: $textFieldValue,
                           sliderValue: $sliderValue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
