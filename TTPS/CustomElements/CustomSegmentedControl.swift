//
//  CustomSegmentedControl.swift
//  Asset Management
//
//  Created by Supriyo Dey on 06/10/23.
//

import UIKit

class CustomSegmentedControl: UIControl {
    private var buttons = [UIButton]()
    private var selector: UIView!
    
    var selectedSegmentIndex = 0
    
    var bgColor: UIColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.00)
    var selectorColor: UIColor = UIColor(red: 0.16, green: 0.56, blue: 0.85, alpha: 1.00)
    var selectedTextColor: UIColor = UIColor.white
    var textColor: UIColor = UIColor(red: 0.47, green: 0.47, blue: 0.47, alpha: 1.00)
    
    var buttonTitles: [String] = [] {
        didSet {
            setupButtons()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButtons()
    }
    
    private func setupButtons() {
        layer.cornerRadius = 25
        backgroundColor = bgColor
        // Remove existing buttons and selector
        buttons.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        selector?.removeFromSuperview()
        
        
        // Add selector view
        let selectorWidth = frame.width / CGFloat(buttonTitles.count)
        let selectorHeight = frame.height
        
        
        selector = UIView(frame: CGRect(x: 5, y: 5, width: selectorWidth-10, height: selectorHeight-10))
        selector.layer.cornerRadius = 20
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        for (index, title) in buttonTitles.enumerated() {
            let button = UIButton(type: .custom)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont(name: "Ubuntu Regular", size: 18)//.systemFont(ofSize: 18)
            button.setTitleColor(selectedSegmentIndex==index ? selectedTextColor : textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            addSubview(button)
        }

        
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var buttonX: CGFloat = 0
        let buttonY: CGFloat = 0
        let buttonWidth = frame.width / CGFloat(buttons.count)
        let buttonHeight = frame.height
        
        for button in buttons {
            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
            buttonX += buttonWidth
        }
        
        //up[date selector width
        let selectorWidth = frame.width / CGFloat(buttonTitles.count)
        let selectorHeight = frame.height
        selector.frame = CGRect(x: 5, y: 5, width: selectorWidth-10, height: selectorHeight-10)
        
        // Set initial selector position based on selected segment index
        let selectorX = buttonWidth * CGFloat(selectedSegmentIndex)
        selector.frame.origin.x = selectorX+5
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        for (index, button) in buttons.enumerated() {
            if button == sender {
                selectedSegmentIndex = index
            }
        }
        
        // Animate selector movement
        UIView.animate(withDuration: 0.3) {
            let selectorX = self.frame.width / CGFloat(self.buttons.count) * CGFloat(self.selectedSegmentIndex)
            self.selector.frame.origin.x = selectorX+5
            for btn in self.buttons {
                btn.setTitleColor(self.textColor, for: .normal)
            }
            self.buttons[self.selectedSegmentIndex].setTitleColor(self.selectedTextColor, for: .normal)
        }
        
        // Notify the target of the value change
        sendActions(for: .valueChanged)
    }
}
