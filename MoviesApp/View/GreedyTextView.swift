//
//  GreedyTextView.swift
//  MoviesApp
//
//  Created by Davis on 2/26/21.
//

import Foundation
import SwiftUI
import UIKit

/// A text view that becomes first responder
struct GreedyTextField: UIViewRepresentable {

    class Coordinator: NSObject {

        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        @objc func textFieldDidChangeText(textField: UITextField) {
            _text.wrappedValue = textField.text ?? ""
        }
    }

    @Binding var text: String
    
    var placeholder: String
    
    var uiFont: UIFont = UIFont.systemFont(ofSize: 28)
    
    func makeUIView(context: UIViewRepresentableContext<GreedyTextField>) -> UITextField {
        let textField = UITextField()
        textField.font = uiFont
        textField.placeholder = placeholder
        textField.addTarget(context.coordinator, action: #selector(context.coordinator.textFieldDidChangeText(textField:)), for: .editingChanged)
        textField.autocorrectionType = .no
        textField.textAlignment = .center
        return textField
    }

    func makeCoordinator() -> GreedyTextField.Coordinator {
        return Coordinator(text: $text)
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<GreedyTextField>) {
        uiView.becomeFirstResponder()
    }
}
