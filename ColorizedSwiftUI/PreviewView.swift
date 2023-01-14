//
//  PreviewView.swift
//  ColorizedSwiftUI
//
//  Created by Eugene on 13.01.23.
//

import SwiftUI

struct PreviewView: View {
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .frame(height: 200)
            .foregroundColor(color)
    }
}

struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView(color: .black).previewLayout(.sizeThatFits)
    }
}
