// Created by byo.

import UIKit

class TitleContentTableViewCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        selectionStyle = .none
        [titleLabel, contentLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        let leading: CGFloat = 20
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leading),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            contentLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 12),
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leading),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
