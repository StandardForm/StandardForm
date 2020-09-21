//
//  SelectionField.swift
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

open class SelectionField: Field {

    open private(set) weak var cell: UITableViewCell?

    open internal(set) var isSelected = false
    open var isEnabled = true {
        didSet { configureCell() }
    }

    open var text: String? {
        didSet { cell?.textLabel?.text = text }
    }
    open var detailText: String? {
        didSet { cell?.detailTextLabel?.text = detailText }
    }
    public let appearance: Appearance

    public init(text: String? = nil,
                detailText: String? = nil,
                appearance: Appearance = DefaultAppearance()) {
        self.text = text
        self.detailText = detailText
        self.appearance = appearance
    }

    open func dequeueReusableCell(forTableView tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = String(describing: SelectionField.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ?? .init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.cell = cell
        cell.textLabel?.text = text
        cell.detailTextLabel?.text = detailText
        configureCell()
        return cell
    }

    open func configureCell() {
        guard let cell = cell else { return }
        cell.selectionStyle = isEnabled ? .default : .none
        cell.tintColor = isEnabled ? .systemBlue : .lightGray
        cell.textLabel?.textColor = isEnabled ? appearance.label : .lightGray
        cell.detailTextLabel?.textColor = isEnabled ? appearance.label : .lightGray
        cell.accessoryType = isSelected ? .checkmark : .none
    }

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard isEnabled else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        isSelected = !isSelected
        configureCell()
    }
}
