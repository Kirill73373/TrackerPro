//
//  BlurEffectView.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 12.03.2023.
//

import UIKit

final class BlurEffectView: UIVisualEffectView {
    
    private var animator = UIViewPropertyAnimator(duration: 1, curve: .linear)
    
    override func didMoveToSuperview() {
        guard let superview = superview else { return }
        backgroundColor = .clear
        frame = superview.bounds
        setupBlur()
    }
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        animator.stopAnimation(true)
    }
    
    @objc private func willEnterForeground() {
        setupBlur()
    }
    
    private func setupBlur() {
        animator.stopAnimation(true)
        effect = nil
        
        animator.addAnimations { [weak self] in
            guard let self = self else { return }
            self.effect = UIBlurEffect(style: .light)
        }
        animator.fractionComplete = 0.15
    }
}
