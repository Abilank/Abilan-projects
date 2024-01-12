//
//  PDFViewController.swift
//  EG
//
//  Created by MACPRO-108 on 11/01/24.
//

import UIKit
import SDWebImage
class PDFViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    
    
    @IBOutlet weak var Morelabel: UILabel!
    @IBOutlet weak var Pdftableview: UITableView!
    @IBOutlet weak var topview: UIView!
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    var pdfarray : [pdfValueModel]!
    var fileURL: URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Morelabel.text = "More"
        self.Morelabel.textAlignment = .center
        self.Morelabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.Morelabel.textColor = .white
        self.topview.setBottomViewCornerRadius(radius: 15)
        registerCV()
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        // Do any additional setup after loading the view.
    }
    
    func registerCV(){
        self.Pdftableview.register(UINib(nibName: "PDFViewCell", bundle: nil), forCellReuseIdentifier: "PDFViewCell")
        self.Pdftableview.allowsSelection = true
        self.Pdftableview.dataSource = self
        self.Pdftableview.delegate = self
        self.Pdftableview.reloadData()
    }
    
    func checkFileIsExitsts(with id: String) -> Bool{
        let fileURL = makeURL(with: id)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            print("File exists!")
            // Proceed with actions if the file exists
        } else {
            print("File does not exist.")
            // Handle the situation if the file is not found
        }
        return FileManager.default.fileExists(atPath: fileURL.path)
    }
    
    func makeURL(with id: String) -> URL{
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectoryURL.appendingPathComponent("\(id).pdf")
    }
    
    @objc func downloadPDF(_ sender: UIButton) {
        // Replace "your_pdf_url.pdf" with the actual URL of the PDF you want to download
        let content = self.pdfarray[sender.tag]
        let pdfURLString = content.url ?? ""
        activityIndicator.startAnimating()
        // Convert the string URL to a URL object
        if let pdfURL = URL(string: pdfURLString) {
            // Create a URLSession to handle the download task
            let session = URLSession(configuration: .default)
            
            // Create a download task
            let downloadTask = session.downloadTask(with: pdfURL) { (temporaryURL, response, error) in
                // Check for errors
                if let error = error {
                    print("Error downloading PDF: \(error.localizedDescription)")
                    return
                }
                // Check if a temporary URL was returned
                guard let temporaryURL = temporaryURL else {
                    print("Temporary URL is nil")
                    return
                }
                do {
                    // Get the documents directory URL
                    let documentsDirectoryURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    
                    // Append the file name to the documents directory URL
                    let destinationURL = documentsDirectoryURL.appendingPathComponent("\(String(describing: content.id ?? "")).pdf")
                    
                    
                    // Move the file from the temporary location to the documents directory
                    
                    try FileManager.default.moveItem(at: temporaryURL, to: destinationURL)
                    content.fileURL = destinationURL
                    content.isdownloaded = true
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.Pdftableview.reloadData()
                        
                    }
                    print("PDF downloaded successfully. File saved at: \(destinationURL)")
                } catch {
                    print("Error moving file: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.view.makeToast("File is already downloaded", position: .center)
                    }
                }
            }
            // Start the download task
            downloadTask.resume()
        } else {
            print("Invalid URL")
        }
    }
}


//MARK: TABLEVIEW DELEGATE AND DATA SOURCE METHODS
extension PDFViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pdfarray.count - 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PDFViewCell", for: indexPath) as! PDFViewCell
        cell.selectionStyle = .none
        
        let Dict = pdfarray[indexPath.row]
        
        let userimgURL = URL.init(string: Dict.cover)
        cell.pdfcoverimg.sd_setImage(with: userimgURL)
        cell.titlelbl.text = Dict.title
        cell.desclbl.text = Dict.author
        cell.contentlbl.text = Dict.ISBN
        cell.wholeview.backgroundColor = .gray.withAlphaComponent(0.1)
        cell.wholeview.crapView(radius: 5)
        cell.pdfcoverimg.crapView(radius: 5)
        
        
        Dict.isdownloaded = checkFileIsExitsts(with: Dict.id ?? "")
        if Dict.isdownloaded{
            Dict.fileURL = makeURL(with: Dict.id!)
            cell.downloadbtn.setImage(UIImage(named: "Downloded"), for: .normal)
        } else {
            cell.downloadbtn.setImage(UIImage(named: "Downloding"), for: .normal)
            cell.downloadbtn.addTarget(self, action: #selector(downloadPDF(_:)), for: .touchUpInside)
            cell.downloadbtn.tag = indexPath.row
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let object = pdfarray[indexPath.row]
        if object.isdownloaded {
            let fileURL = object.fileURL!
            let vc = DocumentViewController(fileURL: fileURL)
            navigationController?.pushViewController(vc, animated: true)
        } else{
            print("file Not downloaded")
        }
    }
    
}
