//
//  DestructiveButtonField.swift
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

open class DestructiveButtonField: Field {

    open weak var tableViewCellProvider: TableViewCellProviding?

    public let id: UUID
    open var text: String? {
        didSet { cell?.textLabel?.text = text }
    }
    public let selectionHandler: () -> Void

    public init(id: UUID = .init(),
                text: String? = nil,
                selectionHandler: @escaping () -> Void) {
        self.id = id
        self.text = text
        self.selectionHandler = selectionHandler
    }

    open func dequeueReusableCell(forTableView tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = String(describing: ButtonField.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ?? .init(style: .default, reuseIdentifier: reuseIdentifier)
        cell.textLabel?.text = text
        cell.textLabel?.textColor = .systemRed
        return cell
    }

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectionHandler()
    }
}
