//
//  CustomButton.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 12.03.2023.
//

import Foundation
import UIKit

final class CustomButton: UIButton {
    
    //MARK: - Image Type
    
    enum ImageType {
        case notIcon
        case leftIcon
        case rightIcon
        case centerIcon
    }
    
    //MARK: - UI
    
    private let containerView: UIView = {
        let vw = UIView()
        vw.isUserInteractionEnabled = false
        return vw
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stc = UIStackView()
        stc.axis = .horizontal
        stc.alignment = .center
        stc.distribution = .equalCentering
        stc.isUserInteractionEnabled = false
        return stc
    }()
    
    private let iconImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.isUserInteractionEnabled = false
        return img
    }()
    
    private let titleMyLabel: UILabel = {
        let lb = UILabel()
        lb.isUserInteractionEnabled = false
        return lb
    }()
    
    //MARK: - Public property
    
    // UIImageView
    var imageContentMode: UIView.ContentMode = .scaleAspectFit
    var imageSize: CGSize = CGSize(width: 10, height: 10)
    var imagePozitionType: ImageType = .notIcon
    var image: UIImage? = nil
    var corner: CGFloat = 0
    
    // UIStackView
    var spacing: CGFloat = 0
    
    // UILabel
    var textAligment: NSTextAlignment = .natural
    var font: UIFont = .systemFont(ofSize: 10)
    var textColor: UIColor = .white
    var text: String = ""
    
    //View
    
    var bgColor: UIColor = ColorHelper.buttonColor
    
    // Other
    var timeAnimation: CGFloat = 0.25
    var valueIndentEdgesTap: CGFloat = 0
    var tap: (() -> Void)?
    
    //MARK: - Override property
    
    override var isHighlighted: Bool {
        didSet {
            setupActivateAnimationView(isHighlighted)
        }
    }
    
    //MARK: - Private property
    
    private var isActiveTouchInside = false
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override Method
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViewStyle()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 0.7)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard isActiveTouchInside else { return }
        let multiplier = 0.7
        let withTimeInterval = timeAnimation * multiplier
        Timer.scheduledTimer(withTimeInterval: withTimeInterval, repeats: false) { _ in
            self.tap?()
        }
    }
    
    override func point(inside point: CGPoint, with _: UIEvent?) -> Bool {
        let area = bounds.insetBy(dx: -valueIndentEdgesTap, dy: -valueIndentEdgesTap)
        return area.contains(point)
    }
    
    //MARK: - Private Method
    
    private func setupActivateAnimationView(_ isHighlighted: Bool) {
        isActiveTouchInside = isTouchInside
        if isHighlighted {
            usingSpringWithDampingAnimation(withDuration: timeAnimation, usingSpringWithDamping: 0.3, delay: 0) { [weak self] in
                guard let self = self else { return }
                self.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
            }
        } else {
            usingSpringWithDampingAnimation(withDuration: timeAnimation, usingSpringWithDamping: 0.3, delay: 0) { [weak self] in
                guard let self = self else { return }
                self.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }
        }
    }
    
    private func setupViewStyle() {
        isExclusiveTouch = true
        iconImageView.contentMode = imageContentMode
        iconImageView.image = image
        titleMyLabel.textColor = textColor
        titleMyLabel.textAlignment = textAligment
        titleMyLabel.font = font
        titleMyLabel.text = text
        containerView.backgroundColor = bgColor
        getImageType()
        containerView.cornerType(type: .all, radius: corner)
        containerView.appendShadow(color: UIColor(red: 0.534, green: 0.646, blue: 0.749, alpha: 0.48), opacity: 1, radius: 16, offset: CGSize(width: 4, height: 2))
        appendShadow(color: UIColor(red: 1, green: 1, blue: 1, alpha: 1), opacity: 1, radius: 16, offset: CGSize(width: -4, height: -2))
        backgroundColor = .clear
        layer.masksToBounds = false
    }
    
    private func getImageType() {
        switch imagePozitionType {
        case .notIcon:
            containerStackView.addArrangedSubview(titleMyLabel)
        case .leftIcon:
            containerStackView.addArrangedSubview(iconImageView.constrain(width: imageSize.width, height: imageSize.height))
            containerStackView.addArrangedSubview(titleMyLabel)
        case .rightIcon:
            containerStackView.addArrangedSubview(titleMyLabel)
            containerStackView.addArrangedSubview(iconImageView.constrain(width: imageSize.width, height: imageSize.height))
        case .centerIcon:
            containerStackView.addArrangedSubview(iconImageView.constrain(width: imageSize.width, height: imageSize.height))
        }
    }
    
    private func addConstraints() {
        addSubviews(
            containerView
        )
        
        containerView.addSubview(containerStackView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
