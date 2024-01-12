//
//  PDFViewCell.swift
//  EG
//
//  Created by MACPRO-108 on 11/01/24.
//

import UIKit

class PDFViewCell: UITableViewCell {

  
    @IBOutlet weak var wholeview: UIView!
    
    @IBOutlet weak var pdfcoverimg: UIImageView!
    
    @IBOutlet weak var titlelbl: UILabel!
    
    @IBOutlet weak var desclbl: UILabel!
   
    @IBOutlet weak var contentlbl: UILabel!
    
    @IBOutlet weak var downloadbtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
