//
//  UILabelPadded.swift
//  SeeFood
//
//  Created by 206568245 on 3/13/23.
//

import UIKit


class UILabelPadded: UILabel {

    var textEdgeInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textEdgeInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textEdgeInsets.top, left: -textEdgeInsets.left,
                                          bottom: -textEdgeInsets.bottom, right: -textEdgeInsets.right)
        return textRect.inset(by: invertedInsets)
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textEdgeInsets))
    }

    @IBInspectable
    var paddingLeft: CGFloat {
        get { return textEdgeInsets.left }
        set { textEdgeInsets.left = newValue }
    }

    @IBInspectable
    var paddingRight: CGFloat {
        get { return textEdgeInsets.right }
        set { textEdgeInsets.right = newValue }
    }

    @IBInspectable
    var paddingTop: CGFloat {
        get { return textEdgeInsets.top }
        set { textEdgeInsets.top = newValue }
    }

    @IBInspectable
    var paddingBottom: CGFloat {
        get { return textEdgeInsets.bottom }
        set { textEdgeInsets.bottom = newValue }
    }
}
