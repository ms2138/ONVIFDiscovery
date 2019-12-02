
import UIKit

class TableBackgroundView: UIView {
    let messageLabel: UILabel
    let actionButton: UIButton
    let activityIndicator: UIActivityIndicatorView
    let stackView: UIStackView

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        self.messageLabel = UILabel(frame: .zero)
        self.messageLabel.textColor = UIColor.darkGray
        self.messageLabel.font = UIFont.systemFont(ofSize: 20.0)
        self.messageLabel.numberOfLines = 0
        self.messageLabel.textAlignment = .center

        self.actionButton = UIButton(type: .roundedRect)

        self.activityIndicator = UIActivityIndicatorView(style: .large)
        self.activityIndicator.color = .darkGray

        stackView = UIStackView(arrangedSubviews: [self.messageLabel,
                                                   self.actionButton,
                                                   self.activityIndicator])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8.0

        super.init(frame: frame)

        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
