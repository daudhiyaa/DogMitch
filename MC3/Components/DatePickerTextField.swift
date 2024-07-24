import Foundation
import SwiftUI
import UIKit

struct DatePickerTextField: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    private let textField = UITextField()
    private let datePicker = UIDatePicker()
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    public var placeholder: String
    @Binding public var date: Date?
    
    func makeUIView(context: Context) -> UITextField {
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(context.coordinator, action: #selector(context.coordinator.dateValueChanged), for: .valueChanged)
        self.textField.placeholder = self.placeholder
        self.textField.inputView = self.datePicker
        self.textField.delegate = context.coordinator
        self.textField.isUserInteractionEnabled = true // Allow interaction
        
        // Accessory View
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: context.coordinator, action: #selector(context.coordinator.doneButtonAction))
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        self.textField.inputAccessoryView = toolbar
        
        self.datePicker.maximumDate = Date()
        
        return self.textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if let selectedDate = self.date {
            uiView.text = self.dateFormatter.string(from: selectedDate)
        }
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: DatePickerTextField
        
        init(parent: DatePickerTextField) {
            self.parent = parent
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Prevent any manual changes to the text
            return false
        }
        
        @objc func dateValueChanged() {
            self.parent.date = self.parent.datePicker.date
        }
        
        @objc func doneButtonAction() {
            if self.parent.date == nil {
                self.parent.date = self.parent.datePicker.date
            }
            self.parent.textField.resignFirstResponder()
        }
    }
}
