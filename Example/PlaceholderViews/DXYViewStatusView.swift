//
//  DXYViewStatusView.swift
//  Example
//
//  Created by xiongyongjie on 2019/7/31.
//  Copyright © 2019 Alexander Schuch. All rights reserved.
//

import Foundation
import UIKit
import StatefulViewController

class DXYViewStatusView: BasicPlaceholderView {
    
    var status = StatefulViewControllerState.content
    var showPlaceholderImage = true
    var showActionButton = true
    var customDescriptionString:String?
    var customImage: UIImage?
    var customButtonTitle:String?
    
    let actionButton = UIButton.init()
    let placeholderImageView = UIImageView.init()
    let descriptionLabel = UILabel.init()
    
    init(status:StatefulViewControllerState,descriptionSring:String?,buttonTitle:String?,placeholderImage:UIImage?,showPlaceholderImage: Bool = true,showActionButton:Bool = true) {
        super.init(frame: CGRect.init())
        self.status = status
        self.showPlaceholderImage = showPlaceholderImage
        self.showActionButton = showActionButton
        self.customDescriptionString = descriptionSring
        self.customImage = placeholderImage
        self.customButtonTitle = buttonTitle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView() {
        super.setupView()
        
        descriptionLabel.text = customDescriptionString ?? defaultDescription()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        centerView.addSubview(descriptionLabel)
        
        placeholderImageView.image = customImage ?? defaultPlaceholderImage()
        placeholderImageView.contentMode = .scaleAspectFill
        placeholderImageView.translatesAutoresizingMaskIntoConstraints = false
        if showPlaceholderImage { centerView.addSubview(placeholderImageView)}
        
        actionButton.setTitle(customButtonTitle ?? "重试", for: .normal)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.backgroundColor = .green
        if showActionButton { centerView.addSubview(actionButton)}
        
        let views = ["label": descriptionLabel,
                     "image": placeholderImageView,
                     "button": actionButton]
        let labelConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-|", options: .alignAllCenterX, metrics: nil, views: views)
        let imageConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image]-|", options: .alignAllCenterX, metrics: nil, views: views)
        let buttonWConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[button]-|", options: .alignAllCenterX, metrics: nil, views: views)
        let buttonHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[button(30)]|", options:.alignAllCenterX , metrics: nil, views: views)
        
        let vConstaints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image]-53-[label]-20-[button]-|", options: .alignAllCenterX, metrics: nil, views: views)
        centerView.addConstraints(labelConstraints)
        centerView.addConstraints(imageConstraints)
        centerView.addConstraints(buttonWConstraints)
        centerView.addConstraints(buttonHConstraints)
        centerView.addConstraints(vConstaints)
    }
}

extension DXYViewStatusView {
    
    func defaultDescription() -> String {
        switch status {
        case .content:
            return ""
        case .loading:
            return "加载中..."
        case .error:
            return "出现了一些错误>﹏<"
        case .empty:
            return "暂无数据ಠ_ಠ"
        }
    }
    
    func defaultPlaceholderImage() -> UIImage? {
        switch status {
        case .content:
            return nil
        case .loading:
            return nil
        case .error:
            return UIImage.init(named: "emptyData")
        case .empty:
            return UIImage.init(named: "emptyData")
        }
    }

}
