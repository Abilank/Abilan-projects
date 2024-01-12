//
//  DocumentViewController.swift
//  EG
//
//  Created by alagu-16152 on 12/01/24.
//

import UIKit
import PDFKit

class DocumentViewController: UIViewController {

    var fileURL: URL!
    
    @IBOutlet weak var pdfView: PDFView!
    
    @IBOutlet weak var topview: UIView!
    init(fileURL: URL) {
        super.init(nibName: "DocumentViewController", bundle: nil)
        self.fileURL = fileURL
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        topview.setBottomViewCornerRadius(radius: 15)
        displayPDF(url: fileURL)
    }


    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func displayPDF(url: URL) {
        guard let pdfDocument = PDFDocument(url: url) else {
            print("Failed to load the PDF document.")
            return
        }
        pdfView.document = pdfDocument
        // Enable automatic scaling of the PDF view to fit the content within the available space
        pdfView.autoScales = true
    }

}
