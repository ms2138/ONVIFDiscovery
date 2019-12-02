
import UIKit

class TableBackgroundView: UIView {
    let messageLabel: UILabel
    let actionButton: UIButton
    let activityIndicator: UIActivityIndicatorView

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

        super.init(frame: frame)
    }
}
