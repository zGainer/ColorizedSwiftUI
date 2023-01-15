//
//  TextFieldView.swift
//  ColorizedSwiftUI
//
//  Created by Eugene on 14.01.23.
//

import SwiftUI

struct EnterColorView: View {

    @Binding var textFieldValue: String

    var body: some View {
        TextField("", text: $textFieldValue)
            .frame(width: 50)
            .textFieldStyle(.roundedBorder)
            .multilineTextAlignment(.trailing)
            .keyboardType(.numberPad)
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        EnterColorView(textFieldValue: .constant("234"))
            .previewLayout(.sizeThatFits)
    }
}
