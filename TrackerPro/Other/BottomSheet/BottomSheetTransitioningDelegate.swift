//
//  BottomSheetTransitioningDelegate.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 12.03.2023.
//

import UIKit

final class BottomSheetTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var closeVC: (() -> Void)?
    
    private weak var bottomSheetPresentationController: BottomSheetPresentationController?
    
    var preferredSheetTopInset: CGFloat
    var preferredSheetCornerRadius: CGFloat
    var preferredSheetSizingFactor: CGFloat
    var preferredSheetBackdropColor: UIColor
    
    var tapToDismissEnabled: Bool = true {
        didSet {
            bottomSheetPresentationController?.tapGestureRecognizer.isEnabled = tapToDismissEnabled
        }
    }
    
    var panToDismissEnabled: Bool = true {
        didSet {
            bottomSheetPresentationController?.panToDismissEnabled = panToDismissEnabled
        }
    }
    
    init(
        preferredSheetTopInset: CGFloat,
        preferredSheetCornerRadius: CGFloat,
        preferredSheetSizingFactor: CGFloat,
        preferredSheetBackdropColor: UIColor
    ) {
        self.preferredSheetTopInset = preferredSheetTopInset
        self.preferredSheetCornerRadius = preferredSheetCornerRadius
        self.preferredSheetSizingFactor = preferredSheetSizingFactor
        self.preferredSheetBackdropColor = preferredSheetBackdropColor
        super.init()
    }
    
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        let bottomSheetPresentationController = BottomSheetPresentationController(
            presentedViewController: presented,
            presenting: presenting ?? source,
            sheetTopInset: preferredSheetTopInset,
            sheetCornerRadius: preferredSheetCornerRadius,
            sheetSizingFactor: preferredSheetSizingFactor,
            sheetBackdropColor: preferredSheetBackdropColor
        )
        bottomSheetPresentationController.tapGestureRecognizer.isEnabled = tapToDismissEnabled
        bottomSheetPresentationController.panToDismissEnabled = panToDismissEnabled
        
        self.bottomSheetPresentationController = bottomSheetPresentationController
        
        return bottomSheetPresentationController
    }
    
    func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        guard
            let bottomSheetPresentationController = dismissed.presentationController as? BottomSheetPresentationController,
            bottomSheetPresentationController.bottomSheetInteractiveDismissalTransition.wantsInteractiveStart
        else {
            return nil
        }
        bottomSheetPresentationController.closeVC = closeVC
        return bottomSheetPresentationController.bottomSheetInteractiveDismissalTransition
    }
    
    func interactionControllerForDismissal(
        using animator: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        animator as? BottomSheetInteractiveDismissalTransition
    }
}

final class BottomSheetPresentationController: UIPresentationController {
    
    var closeVC: (() -> Void)?
    private let backdropView = BlurEffectView()
    
    let bottomSheetInteractiveDismissalTransition = BottomSheetInteractiveDismissalTransition()
    
    let sheetTopInset: CGFloat
    let sheetCornerRadius: CGFloat
    let sheetSizingFactor: CGFloat
    let sheetBackdropColor: UIColor
    
    private(set) lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        gesture.cancelsTouchesInView = false
        return gesture
    }()
    
    private lazy var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan))
    var panToDismissEnabled: Bool = true
    
    init(
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?,
        sheetTopInset: CGFloat,
        sheetCornerRadius: CGFloat,
        sheetSizingFactor: CGFloat,
        sheetBackdropColor: UIColor
    ) {
        self.sheetTopInset = sheetTopInset
        self.sheetCornerRadius = sheetCornerRadius
        self.sheetSizingFactor = sheetSizingFactor
        self.sheetBackdropColor = sheetBackdropColor
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    @objc private func onTap(_ gestureRecognizer: UITapGestureRecognizer) {
        guard
            let presentedView = presentedView,
            let containerView = containerView,
            !presentedView.frame.contains(gestureRecognizer.location(in: containerView))
        else {
            self.presentedView?.endEditing(true)
            return
        }
        
        presentingViewController.dismiss(animated: true)
    }
    
    @objc private func onPan(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let presentedView = presentedView else {
            return
        }
        presentedView.endEditing(true)
        let translation = gestureRecognizer.translation(in: presentedView)
        
        let progress = translation.y / presentedView.frame.height
        
        switch gestureRecognizer.state {
        case .began:
            bottomSheetInteractiveDismissalTransition.start(
                moving: presentedView, interactiveDismissal: panToDismissEnabled
            )
        case .changed:
            if panToDismissEnabled && progress > 0 && !presentedViewController.isBeingDismissed {
                presentingViewController.dismiss(animated: true)
            }
            bottomSheetInteractiveDismissalTransition.move(
                presentedView, using: translation.y
            )
        default:
            let velocity = gestureRecognizer.velocity(in: presentedView)
            bottomSheetInteractiveDismissalTransition.stop(
                moving: presentedView, at: translation.y, with: velocity
            )
        }
    }
    
    override func presentationTransitionWillBegin() {
        guard let presentedView = presentedView else {
            return
        }
        
        presentedView.addGestureRecognizer(panGestureRecognizer)
        
        presentedView.layer.cornerRadius = sheetCornerRadius
        presentedView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        
        guard let containerView = containerView else {
            return
        }
        
        containerView.addGestureRecognizer(tapGestureRecognizer)
        
        containerView.addSubview(backdropView)
        
        backdropView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backdropView.topAnchor.constraint(
                equalTo: containerView.topAnchor
            ),
            backdropView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor
            ),
            backdropView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor
            ),
            backdropView.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor
            ),
        ])
        
        containerView.addSubview(presentedView)
        
        presentedView.translatesAutoresizingMaskIntoConstraints = false
        
        let preferredHeightConstraint = presentedView.heightAnchor.constraint(equalToConstant: sheetSizingFactor)
        
        preferredHeightConstraint.priority = .fittingSizeLevel
        
        let topConstraint = presentedView.topAnchor.constraint(
            greaterThanOrEqualTo: containerView.safeAreaLayoutGuide.topAnchor,
            constant: sheetTopInset
        )
        
        topConstraint.priority = .required - 1
        
        let heightConstraint = presentedView.heightAnchor.constraint(
            equalToConstant: 0
        )
        
        let bottomConstraint = presentedView.bottomAnchor.constraint(
            equalTo: containerView.bottomAnchor
        )
        
        NSLayoutConstraint.activate([
            topConstraint,
            presentedView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor
            ),
            presentedView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor
            ),
            bottomConstraint,
            preferredHeightConstraint
        ])
        
        bottomSheetInteractiveDismissalTransition.bottomConstraint = bottomConstraint
        bottomSheetInteractiveDismissalTransition.heightConstraint = heightConstraint
        
        guard let transitionCoordinator = presentingViewController.transitionCoordinator else {
            return
        }
        
        transitionCoordinator.animate { context in
            self.backdropView.alpha = 1
        }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            backdropView.removeFromSuperview()
            presentedView?.removeGestureRecognizer(panGestureRecognizer)
            containerView?.removeGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        guard let transitionCoordinator = presentingViewController.transitionCoordinator else {
            return
        }
        
        transitionCoordinator.animate { context in
            self.backdropView.alpha = 0
        }
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            backdropView.removeFromSuperview()
            presentedView?.removeGestureRecognizer(panGestureRecognizer)
            containerView?.removeGestureRecognizer(tapGestureRecognizer)
            closeVC?()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        panGestureRecognizer.isEnabled = false
        coordinator.animate(alongsideTransition: nil) { context in
            self.panGestureRecognizer.isEnabled = true
        }
    }
}

final class BottomSheetInteractiveDismissalTransition: NSObject {
    
    private let stretchOffset: CGFloat = 16
    private let maxTransitionDuration: CGFloat = 0.25
    private let minTransitionDuration: CGFloat = 0.15
    private let animationCurve: UIView.AnimationCurve = .easeIn
    
    private weak var transitionContext: UIViewControllerContextTransitioning?
    
    private var heightAnimator: UIViewPropertyAnimator?
    private var offsetAnimator: UIViewPropertyAnimator?
    
    private var interactiveDismissal: Bool = false
    
    var bottomConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    private func createHeightAnimator(animating view: UIView, from height: CGFloat) -> UIViewPropertyAnimator {
        let propertyAnimator = UIViewPropertyAnimator(
            duration: minTransitionDuration,
            curve: animationCurve
        )
        
        heightConstraint?.constant = height
        heightConstraint?.isActive = true
        
        let finalHeight = height + stretchOffset
        
        propertyAnimator.addAnimations {
            self.heightConstraint?.constant = finalHeight
            view.superview?.layoutIfNeeded()
        }
        
        propertyAnimator.addCompletion { position in
            self.heightConstraint?.isActive = position == .end ? true : false
            self.heightConstraint?.constant = position == .end ? finalHeight : height
        }
        
        return propertyAnimator
    }
    
    private func createOffsetAnimator(animating view: UIView, to offset: CGFloat) -> UIViewPropertyAnimator {
        let propertyAnimator = UIViewPropertyAnimator(
            duration: maxTransitionDuration,
            curve: animationCurve
        )
        
        propertyAnimator.addAnimations {
            self.bottomConstraint?.constant = offset
            view.superview?.layoutIfNeeded()
        }
        
        propertyAnimator.addCompletion { position in
            self.bottomConstraint?.constant = position == .end ? offset : 0
        }
        
        return propertyAnimator
    }
    
    private func stretchProgress(basedOn translation: CGFloat) -> CGFloat {
        (translation > 0 ? pow(translation, 0.33) : -pow(-translation, 0.33)) / stretchOffset
    }
}

extension BottomSheetInteractiveDismissalTransition {
    
    func start(moving presentedView: UIView, interactiveDismissal: Bool) {
        self.interactiveDismissal = interactiveDismissal
        
        heightAnimator?.stopAnimation(false)
        heightAnimator?.finishAnimation(at: .start)
        offsetAnimator?.stopAnimation(false)
        offsetAnimator?.finishAnimation(at: .start)
        
        heightAnimator = createHeightAnimator(
            animating: presentedView, from: presentedView.frame.height
        )
        
        if !interactiveDismissal {
            offsetAnimator = createOffsetAnimator(
                animating: presentedView, to: stretchOffset
            )
        }
    }
    
    func move(_ presentedView: UIView, using translation: CGFloat) {
        let progress = translation / presentedView.frame.height
        
        let stretchProgress = stretchProgress(basedOn: translation)
        
        heightAnimator?.fractionComplete = stretchProgress * -1
        offsetAnimator?.fractionComplete = interactiveDismissal ? progress : stretchProgress
        
        transitionContext?.updateInteractiveTransition(progress)
    }
    
    func stop(moving presentedView: UIView, at translation: CGFloat, with velocity: CGPoint) {
        let progress = translation / presentedView.frame.height
        
        let stretchProgress = stretchProgress(basedOn: translation)
        
        heightAnimator?.fractionComplete = stretchProgress * -1
        offsetAnimator?.fractionComplete = interactiveDismissal ? progress : stretchProgress
        
        transitionContext?.updateInteractiveTransition(progress)
        
        let cancelDismiss = !interactiveDismissal || velocity.y < 500 || (progress < 0.5 && velocity.y <= 0)
        
        heightAnimator?.isReversed = true
        offsetAnimator?.isReversed = cancelDismiss
        
        if cancelDismiss {
            transitionContext?.cancelInteractiveTransition()
        } else {
            transitionContext?.finishInteractiveTransition()
        }
        
        if progress < 0 {
            heightAnimator?.addCompletion { _ in
                self.offsetAnimator?.stopAnimation(false)
                self.offsetAnimator?.finishAnimation(at: .start)
            }
            
            heightAnimator?.startAnimation()
        } else {
            offsetAnimator?.addCompletion { _ in
                self.heightAnimator?.stopAnimation(false)
                self.heightAnimator?.finishAnimation(at: .start)
            }
            
            offsetAnimator?.startAnimation()
        }
        
        interactiveDismissal = false
    }
}

extension BottomSheetInteractiveDismissalTransition: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        maxTransitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedView = transitionContext.view(forKey: .from) else { return }
        
        offsetAnimator?.stopAnimation(true)
        
        let offset = presentedView.frame.height
        let offsetAnimator = createOffsetAnimator(animating: presentedView, to: offset)
        
        offsetAnimator.addCompletion { position in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        offsetAnimator.startAnimation()
        
        self.offsetAnimator = offsetAnimator
    }
    
    func interruptibleAnimator(
        using transitionContext: UIViewControllerContextTransitioning
    ) -> UIViewImplicitlyAnimating {
        guard let offsetAnimator = offsetAnimator else {
            fatalError("Somehow the offset animator was not set")
        }
        
        return offsetAnimator
    }
}

extension BottomSheetInteractiveDismissalTransition: UIViewControllerInteractiveTransitioning {
    
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        guard
            transitionContext.isInteractive,
            let presentedView = transitionContext.view(forKey: .from)
        else {
            return animateTransition(using: transitionContext)
        }
        
        let fractionComplete = offsetAnimator?.fractionComplete ?? 0
        
        offsetAnimator?.stopAnimation(true)
        
        let offset = presentedView.frame.height
        let offsetAnimator = createOffsetAnimator(animating: presentedView, to: offset)
        
        offsetAnimator.addCompletion { position in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        offsetAnimator.fractionComplete = fractionComplete
        
        transitionContext.updateInteractiveTransition(fractionComplete)
        
        self.offsetAnimator = offsetAnimator
        self.transitionContext = transitionContext
    }
    
    var wantsInteractiveStart: Bool {
        interactiveDismissal
    }
    
    var completionCurve: UIView.AnimationCurve {
        animationCurve
    }
    
    var completionSpeed: CGFloat {
        1.0
    }
}


