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
            .overlay( RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 4) )
    }
}

struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView(color: .black).previewLayout(.sizeThatFits)
    }
}
