//
//  MotionListTableViewCell.swift
//  GyroData
//
//  Created by 이호영 on 2022/12/27.
//

import UIKit

class MotionListTableViewCell: UITableViewCell {

    static let cellIdentifier = "MotionListCell"
    
    private let cellStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        timeLabel.text = ""
        dateLabel.text = ""
        timeLabel.text = ""
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        addSubViews()
    }
    
    private func addSubViews() {
        
        self.addSubview(cellStack)
        
        cellStack.addArrangedSubview(contentStack)
        cellStack.addArrangedSubview(timeLabel)
        
        contentStack.addArrangedSubview(dateLabel)
        contentStack.addArrangedSubview(titleLabel)

        NSLayoutConstraint.activate([
            cellStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                                 constant: 20),
            cellStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                 constant: 40),
            cellStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -40),
            cellStack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                                 constant: -20),
            timeLabel.widthAnchor.constraint(equalToConstant: 60)
            
        ])
    }
    
    public func configure(motion: Motion) {
        titleLabel.text = motion.motionType.rawValue
        dateLabel.text = "2022/09/18 14:50:43" // TODO: formatter 적용하면 수정할게요...
        timeLabel.text = String(motion.time)
    }

}
