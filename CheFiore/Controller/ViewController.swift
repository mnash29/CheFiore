//
//  ViewController.swift
//  CheFiore
//
//  Created by 206568245 on 4/18/23.
//

import UIKit
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!

    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }

    override func viewWillAppear(_ animated: Bool) {

        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation Controller does not exist") }

        let navBarUIColor = K.navBarTintColor

        navBar.scrollEdgeAppearance?.backgroundColor = navBarUIColor
        navBar.scrollEdgeAppearance?.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "palatino-bold", size: CGFloat(24.0))!,
        ]
        navBar.topItem?.rightBarButtonItem?.tintColor = UIColor.white
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { fatalError("Error casting UIImagePickerConroller.InfoKey.originalImage as UIImage") }

        imageView.image = userPickedImage
        imagePicker.dismiss(animated: true)
    }

    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true)
    }

}

