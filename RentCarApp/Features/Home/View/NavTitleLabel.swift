//
//  NavTitleLabel.swift
//  RentCarApp
//
//  Created by Sebastian Maludziński on 06/01/2022.
//

import UIKit

final class NavTitleLabel: UIView {
    
    private lazy var titleStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 35)
        label.attributedText = createAttributedText()
        label.textColor = UIColor(named: "Font")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        titleStack.sizeToFit()
        
        self.addSubview(titleStack)
        titleStack.addArrangedSubview(titleLabel)
        titleStack.addArrangedSubview(UIView())
    }
    
    private func createAttributedText() -> NSAttributedString {
        let string: String = "Choose a Car"
        
        let attributedText = NSMutableAttributedString(string: string)
        attributedText.addAttribute(.font, value: UIFont(name: "HelveticaNeue-Medium", size: 35) as Any, range: NSRange(location: 0, length: 6))
        return attributedText
    }
}
