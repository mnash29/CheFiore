//
//  ViewController.swift
//  CheFiore
//
//  Created by 206568245 on 4/18/23.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var classLabel: UILabelPadded!
    @IBOutlet weak var confidenceLabel: UILabelPadded!

    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false

        imageView.image = UIImage(named: "camera.fill")

        classLabel.text = ""
        confidenceLabel.text = ""
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

        guard let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { fatalError("Could not cast UIImagePickerConroller.InfoKey.originalImage as UIImage") }

        imageView.image = userPickedImage
        imagePicker.dismiss(animated: true)

        guard let ciImage = CIImage(image: userPickedImage) else { fatalError("Could not converting UIImage to CIImage.") }

        detect(with: ciImage)
    }

    func detect(with image: CIImage) {

        guard let model = try? FlowerClassifier(configuration: .init()).model else { fatalError("Could not initilize FlowerClassifier model.") }

        guard let mlModel = try? VNCoreMLModel(for: model) else { fatalError("Could not initialize CoreML model.") }

        let request = VNCoreMLRequest(model: mlModel) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else { fatalError("Model failed to process image") }

            guard let prediction = results.first else { return }

            self.classLabel.text = "Label: \(prediction.identifier.capitalized)"
            self.confidenceLabel.text = String(format: "Score: %.0f%%", prediction.confidence * 100)
        }

        let handler = VNImageRequestHandler(ciImage: image)

        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }

    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true)
    }

}
