//
//  CustomSegmentedPicker.swift
//  MC3
//
//  Created by Jeffri Lieca H on 17/07/24.
//

import SwiftUI

struct CustomSegmentedPicker: UIViewRepresentable {
    @Binding var selection: Int
    var items: [String]

    class Coordinator: NSObject {
        var parent: CustomSegmentedPicker

        init(_ parent: CustomSegmentedPicker) {
            self.parent = parent
        }

        @objc func valueChanged(_ sender: UISegmentedControl) {
            parent.selection = sender.selectedSegmentIndex
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> CustomSegmentedControl {
        let control = CustomSegmentedControl(items: items)
        control.selectedSegmentIndex = selection

        control.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged(_:)), for: .valueChanged)

        // Custom appearance
        control.selectedSegmentTintColor = .white
        control.setTitleTextAttributes([.foregroundColor: UIColor(hex: "06CACD")], for: .selected)
        control.setTitleTextAttributes([.foregroundColor: UIColor(hex: "929191")], for: .normal)
        control.backgroundColor = UIColor(hex: "EEEEEF")
        

        return control
    }

    func updateUIView(_ uiView: CustomSegmentedControl, context: Context) {
        uiView.selectedSegmentIndex = selection
    }
}

