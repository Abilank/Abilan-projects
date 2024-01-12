//
//  SplashViewController.swift
//  EG
//
//  Created by MACPRO-108 on 11/01/24.
//

import UIKit

class SplashViewController: UIViewController {
 
    
    @IBOutlet weak var loaderimg: UIImageView!
    
    var construction: [pdfValueModel]!
    override func viewDidLoad() {
        super.viewDidLoad()
        getConstruction()
        animateImage()
    }
    func getConstruction(){
        let url = "https://6593a93a1493b0116068da73.mockapi.io/api/v1/pdf/list/pdf"
        let vm = viewmodelcontroller()
        vm.getmodelconstrutions(url: url, onsucess: { response in
            print("qwerty123",response)
            self.construction = response.resultArr
                let vc = PDFViewController()
                vc.pdfarray = self.construction
                self.navigationController?.pushViewController(vc, animated: true)
        }, onfailure: { error in
            print(error)
        })
    }
    func animateImage() {
         // Set the final position for the image
         let finalPosition = CGPoint(x: 50, y: 50)

         // Set the duration of the animation
        let duration: TimeInterval = 0.5

         // Perform the animation
         UIView.animate(withDuration: duration, animations: {
             // Change the frame or center property to animate the position
             self.loaderimg.frame.origin = finalPosition
         }) { (completed) in
             // This closure is called when the animation is completed
             print("Animation completed!")
         }
     }

}
