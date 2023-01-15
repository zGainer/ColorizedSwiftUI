//
//  ColorLabelView.swift
//  ColorizedSwiftUI
//
//  Created by Eugene on 13.01.23.
//

import SwiftUI

struct SelectColorView: View {
    let tintColor: Color

    @Binding var sliderValue: Double
    
    var body: some View {
        Text("\(lround(sliderValue))")
            .frame(width: 45, alignment: .leading)
            .foregroundColor(.white)
        
        Slider(value: $sliderValue, in: 0...255, step: 1)
            .tint(tintColor)
    }
}

struct ColorLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SelectColorView(tintColor: .red, sliderValue: .constant(54))
            .previewLayout(.sizeThatFits)
    }
}
