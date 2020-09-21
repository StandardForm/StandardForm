//
//  TextInputFieldCell.swift
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

open class TextInputFieldCell: UITableViewCell {

    public let fieldLabel = UILabel()
    public let textField = UITextField()

    private var stackViewHeightConstraint: NSLayoutConstraint?
    private let stackView = UIStackView()

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    open override func prepareForReuse() {
        super.prepareForReuse()
        updateLayout()
    }

    @objc private func didTapContentView(_ sender: UITapGestureRecognizer) {
        textField.becomeFirstResponder()
    }

    private func updateLayout() {
        sizeToFit()

        let height = frame.height - (1 / UIScreen.main.scale)

        if let stackViewHeightConstraint = stackViewHeightConstraint {
            stackViewHeightConstraint.constant = height
        } else {
            stackViewHeightConstraint = stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: height)
            stackViewHeightConstraint?.priority = .defaultHigh
            stackViewHeightConstraint?.isActive = true
        }

        if UIApplication.shared.preferredContentSizeCategory.isAccessibilityCategory {
            textField.textAlignment = .left
            let layoutMargin = UIFontMetrics.default.scaledValue(for: 8)
            stackView.layoutMargins.top = layoutMargin
            stackView.layoutMargins.bottom = layoutMargin
            stackView.axis = .vertical
        } else {
            textField.textAlignment = .right
            stackView.layoutMargins = .zero
            stackView.axis = .horizontal
        }
    }

    private func commonInit() {
        selectionStyle = .none
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapContentView(_:))))

        fieldLabel.adjustsFontForContentSizeCategory = true
        fieldLabel.font = .preferredFont(forTextStyle: .body)
        fieldLabel.setContentHuggingPriority(textField.contentHuggingPriority(for: .horizontal) + 1, for: .horizontal)

        textField.adjustsFontForContentSizeCategory = true
        textField.font = .preferredFont(forTextStyle: .body)

        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true

        stackView.addArrangedSubview(fieldLabel)
        stackView.addArrangedSubview(textField)

        updateLayout()
    }
}
