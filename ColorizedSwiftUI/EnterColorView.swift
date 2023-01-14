//
//  TextFieldView.swift
//  ColorizedSwiftUI
//
//  Created by Eugene on 14.01.23.
//

import SwiftUI

struct EnterColorView: View {
    let textFieldColor: Field
    
    @State private var alertPresented = false

    @Binding var textFieldValue: String
    @Binding var sliderValue: Double
    
    @FocusState private var isInputActive: Bool

//    var focusedField: FocusState<ContentView.Field?>.Binding
    
    var body: some View {
        TextField("", text: $textFieldValue)
            .frame(width: 45)
            .textFieldStyle(.roundedBorder)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .focused($isInputActive)
        //            .focused(focusedField, equals: textFieldColor)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    if isInputActive {
                        Image(systemName: "chevron.up")
                            .foregroundColor(.blue)
                            .onTapGesture {
//                            focusedField = .yellowTextField
                            }
                        
                        Spacer()
                        
                        Button("Done") {
                            checkValue()
                            sliderValue = Double(textFieldValue) ?? sliderValue
                            isInputActive = false
                        }
                        .alert("Error number", isPresented: $alertPresented, actions: {}) {
                            Text("Enter correct number")
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
    }
    
    func checkValue() {
        if Double(textFieldValue)! > 255 {
            textFieldValue = "0"
            alertPresented.toggle()
            
            return
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        EnterColorView(textFieldColor: .redTextField, textFieldValue: .constant("10"), sliderValue: .constant(10))
            .previewLayout(.sizeThatFits)
    }
}
