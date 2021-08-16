//
//  ViewController.swift
//  StackViewPlayground
//
//  Created by Sam Meyer on 8/15/21.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var stackView: NSStackView!
    @IBOutlet var view1: CustomView!
    @IBOutlet var view2: CustomView!
    @IBOutlet var view3: CustomView!
    @IBOutlet var explanationLabel: NSTextField!
    
    @objc var distributionModes: [String] = ["Fill", "Fill Equally", "Fill Proportionally", "Equal Spacing", "Equal Centering"]
    
    var explanations: [String] = [
        "Fill: The sum of the views' widths and spacing must equal the width of the stack view. Each view's intrinsic content size is preferred, and the view with the lowest hugging priority will be stretched to fit the space. If all views have the same hugging priority, the first view will be stretched.",
        "Fill Equally: Same as Fill mode, except each view will have the same width.",
        "Fill Proportionally: Same as Fill Equally mode, except each view's width will be proportional to its intrinsic content size width.",
        "Equal Spacing: Each view will revert to its intrinsic size. Spacing between views will be equal to or greater than spacing.",
        "Equal Centering: Each view will revert to its intrinsic size. Spacing between each view's center will be equal."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stackView.wantsLayer = true
        stackView.layer?.borderWidth = 1.0
        
        view1.contentWidthLabel.intValue = Int32(view1.intrinsicContentSize.width)
        view2.contentWidthLabel.intValue = Int32(view2.intrinsicContentSize.width)
        view3.contentWidthLabel.intValue = Int32(view3.intrinsicContentSize.width)
        view1.contentWidthLabel.toolTip = "Intrinsic content width"
        view2.contentWidthLabel.toolTip = "Intrinsic content width"
        view3.contentWidthLabel.toolTip = "Intrinsic content width"
        
        view1.huggingPriorityLabel.intValue = Int32(view1.contentHuggingPriority(for: .horizontal).rawValue)
        view2.huggingPriorityLabel.intValue = Int32(view2.contentHuggingPriority(for: .horizontal).rawValue)
        view3.huggingPriorityLabel.intValue = Int32(view3.contentHuggingPriority(for: .horizontal).rawValue)
        view1.huggingPriorityLabel.toolTip = "Hugging priority"
        view2.huggingPriorityLabel.toolTip = "Hugging priority"
        view3.huggingPriorityLabel.toolTip = "Hugging priority"
        
        explanationLabel.stringValue = explanations[0]
    }
    
    @IBAction func distributionChanged(_ sender: NSPopUpButton) {
        explanationLabel.stringValue = explanations[sender.indexOfSelectedItem]
        stackView.distribution = NSStackView.Distribution(rawValue: sender.indexOfSelectedItem)!
    }
}

@IBDesignable
class CustomView : NSView {
    @IBInspectable private var _intrinsicSize: NSSize = NSSize(width: 100, height: 100)
    @IBOutlet var contentWidthLabel: NSTextField!
    @IBOutlet var huggingPriorityLabel: NSTextField!
    
    override var intrinsicContentSize: NSSize {
        get {
            return _intrinsicSize
        }
    }
}
