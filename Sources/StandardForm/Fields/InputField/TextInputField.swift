//
//  TextInputField.swift
//  StandardForm
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

open class TextInputField: NSObject, Field, UITextFieldDelegate {

    open weak var tableViewCellProvider: TableViewCellProviding?

    public let id: UUID
    open var label: String? {
        didSet { (cell as? TextInputFieldCell)?.fieldLabel.text = label }
    }
    open var placeholder: String? {
        didSet { (cell as? TextInputFieldCell)?.textField.placeholder = placeholder }
    }
    open var value: String? {
        didSet { (cell as? TextInputFieldCell)?.textField.text = value }
    }
    public let autocapitalizationType: UITextAutocapitalizationType
    public let autocorrectionType: UITextAutocorrectionType
    public let returnKeyType: UIReturnKeyType
    public let appearance: Appearance
    public let returnKeyHandler: (() -> Void)?

    public init(id: UUID = .init(),
                label: String? = nil,
                placeholder: String? = nil,
                value: String? = nil,
                autocapitalizationType: UITextAutocapitalizationType = .sentences,
                autocorrectionType: UITextAutocorrectionType = UITextAutocorrectionType.default,
                returnKeyType: UIReturnKeyType = .default,
                appearance: Appearance = DefaultAppearance(),
                returnKeyHandler: (() -> Void)? = nil) {
        self.id = id
        self.label = label
        self.placeholder = placeholder
        self.value = value
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.returnKeyType = returnKeyType
        self.appearance = appearance
        self.returnKeyHandler = returnKeyHandler
    }

    @objc open func didUpdateText(_ textField: UITextField) {
        value = textField.text
    }

    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        returnKeyHandler?()
        return true
    }

    open func registerCellForCellReuseIdentifier(_ tableView: UITableView) {
        tableView.register(TextInputFieldCell.self, forCellReuseIdentifier: "TextInputFieldCell")
    }

    open func dequeueReusableCell(forTableView tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextInputFieldCell", for: indexPath) as! TextInputFieldCell
        cell.fieldLabel.text = label
        cell.textField.placeholder = placeholder
        cell.textField.text = value
        cell.textField.autocapitalizationType = autocapitalizationType
        cell.textField.returnKeyType = returnKeyType
        cell.textField.addTarget(self, action: #selector(didUpdateText(_:)), for: .editingChanged)
        cell.textField.delegate = self
        cell.textField.tintColor = appearance.tintColor
        return cell
    }
}
