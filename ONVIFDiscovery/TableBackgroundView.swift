
import UIKit

class TableBackgroundView: UIView {
    let messageLabel: UILabel
    let actionButton: UIButton
    let activityIndicator: UIActivityIndicatorView
    let stackView: UIStackView
    var actionButtonTitle: String {
        willSet {
            actionButton.setTitle(newValue, for: .normal)
        }
    }
    var message: String {
        willSet {
            messageLabel.text = newValue
        }
    }
    var handler: (() -> Void)?

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
        self.actionButtonTitle = "Button"

        super.init(frame: frame)

        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        actionButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
}

extension TableBackgroundView {
    func startLoadingOperation() {
        message = messageLabel.text ?? "Label"
        messageLabel.text = "Loading"
        toggleButtonVisibility(animated: false)
        activityIndicator.startAnimating()
    }

    func stopLoadingOperation() {
        messageLabel.text = message
        toggleButtonVisibility(animated: true)
        activityIndicator.stopAnimating()
    }
}

extension TableBackgroundView {
    fileprivate func toggleMessageLabel(animated: Bool) {
        let alpha: CGFloat = messageLabel.alpha == 1.0 ? 0.0 : 1.0
        if animated == true {
            UIView.animate(withDuration: 1.0) {
                  self.messageLabel.alpha = alpha
              }
        } else {
            messageLabel.alpha = alpha
        }
    }

    fileprivate func toggleButtonVisibility(animated: Bool) {
        let alpha: CGFloat = actionButton.alpha == 1.0 ? 0.0 : 1.0
        if animated == true {
            UIView.animate(withDuration: 1.0) {
                self.actionButton.alpha = alpha
            }
        } else {
            actionButton.alpha = alpha
        }
    }
}

extension TableBackgroundView {
    @objc fileprivate func buttonPressed() {
        if (handler != nil) {
            handler!()
        }
    }
}
