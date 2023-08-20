// Created by byo.

import UIKit

class StyledButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            updateBackgroundColorByHighlighted()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }
    
    private func setupStyle() {
        setTitleColor(.purple, for: .normal)
        setTitleColor(.blue, for: .highlighted)
        updateBackgroundColorByHighlighted()
    }
    
    private func updateBackgroundColorByHighlighted() {
        backgroundColor = isHighlighted ? .green : .orange
    }
}
