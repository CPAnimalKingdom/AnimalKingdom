//
//  VideoTableViewCell.swift
//  AnimalKingdom
//
//  Created by Dan on 11/5/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit
import WebKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet var videoView: WKWebView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
