//
//  DebugFormViewController.swift
//  StandardFormDebug
//
//  Copyright (c) 2020 Jason Nam (https://jasonnam.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

final class DebugFormViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "StandardForm"

        let disabledSelectionField = SelectionField(text: "Disabled Toggle")
        disabledSelectionField.isSelected = true
        disabledSelectionField.isEnabled = false

        sections = [
            .init(
                fields: [
                    TextInputField(label: "Name", placeholder: "StandardForm", returnKeyType: .next),
                    EmailInputField(label: "Email", placeholder: "contact@example.com", returnKeyType: .next),
                    PasswordInputField(label: "Password", returnKeyType: .go),
                    ButtonField(text: "Name") {
                        print("\(Date()) ButtonField: Did Tap")
                    },
                    ButtonField(text: "Name", disclosureIndicator: true) {
                        print("\(Date()) ButtonField: Did Tap")
                    },
                    SelectionField(text: "Toggle"),
                    disabledSelectionField
                ]
            ),
            SelectionSection(
                fields: [
                    .init(text: "Option 1"),
                    .init(text: "Option 2"),
                    .init(text: "Option 3")
                ]
            )
        ]
    }
}
