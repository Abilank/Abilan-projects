//
//  UITapGesture+Extension.swift
//  Fundoo
//
//  Created by MAC BOOK on 17/07/22.
//  Copyright © 2022 Hitasoft. All rights reserved.
//
import UIKit

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y);
        var indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        indexOfCharacter = indexOfCharacter + 4
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}


extension UIView {
    
     //MARK: View Tap Gesture
     // In order to create computed properties for extensions, we need a key to
     // store and access the stored property
     fileprivate struct AssociatedObjectKeys {
         static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
     }
     
     fileprivate typealias Action = (() -> Void)?
     
     // Set our computed property type to a closure
     fileprivate var tapGestureRecognizerAction: Action? {
         set {
             if let newValue = newValue {
                 // Computed properties get stored as associated objects
                 objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
             }
         }
         get {
             let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
             return tapGestureRecognizerActionInstance
         }
     }
     
     // This is the meat of the sauce, here we create the tap gesture recognizer and
     // store the closure the user passed to us in the associated object we declared above
     public func addTapGestureRecognizer(action: (() -> Void)?) {
         self.isUserInteractionEnabled = true
         self.tapGestureRecognizerAction = action
         let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
         self.addGestureRecognizer(tapGestureRecognizer)
     }
     
     // Every time the user taps on the UIImageView, this function gets called,
     // which triggers the closure we stored
     @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
         if let action = self.tapGestureRecognizerAction {
             action?()
             print("action")
         } else {
             print("no action")
         }
     }
  
    func roundView(){
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
}
