//
//  FormContentViewController.swift
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

open class FormContentViewController: UITableViewController, TableViewCellProviding {

    open var sections: [Section] = [] {
        didSet {
            for section in sections {
                for var field in section.fields {
                    field.tableViewCellProvider = self
                    field.registerCellForCellReuseIdentifier(tableView)
                }
            }
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .interactive
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            if let transitionCoordinator = transitionCoordinator {
                transitionCoordinator.animate(alongsideTransition: { [weak self] _ in
                    self?.tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
                }, completion: { [weak self] context in
                    if context.isCancelled {
                        self?.tableView.selectRow(at: indexPathForSelectedRow, animated: false, scrollPosition: .none)
                    }
                })
            } else {
                tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
            }
        }
    }

    open override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].fields.count
    }

    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let field = sections[indexPath.section].fields[indexPath.row]
        return field.dequeueReusableCell(forTableView: tableView, atIndexPath: indexPath)
    }

    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        let field = sections[indexPath.section].fields[indexPath.row]
        field.tableView(tableView, didSelectRowAt: indexPath)
    }

    open func tableViewCell(forField field: Field) -> UITableViewCell? {
        let targetFieldID = field.id

        for (sectionIndex, section) in sections.enumerated() {
            for (fieldIndex, field) in section.fields.enumerated() {
                if field.id == targetFieldID {
                    return tableView.cellForRow(at: .init(row: fieldIndex, section: sectionIndex))
                }
            }
        }

        return nil
    }
}
