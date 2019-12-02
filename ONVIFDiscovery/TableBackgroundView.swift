
import UIKit

class TableBackgroundView: UIView {
    let messageLabel: UILabel
    let actionButton: UIButton
    let activityIndicator: UIActivityIndicatorView
    let stackView: UIStackView
    var message: String {
        willSet {
            messageLabel.text = newValue
        }
    }

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

        self.stackView = UIStackView(arrangedSubviews: [self.messageLabel,
                                                        self.actionButton,
                                                        self.activityIndicator])
        self.stackView.axis = .vertical
        self.stackView.alignment = .fill
        self.stackView.distribution = .equalSpacing
        self.stackView.spacing = 8.0

        self.message = "Label"

        super.init(frame: frame)

        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
