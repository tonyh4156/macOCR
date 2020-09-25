//
//  main.swift
//  macOCR
//
//  Created by Tony Hu on 9/24/20.
//  Copyright © 2020 Tony Hu. All rights reserved.
//

import Foundation
import Vision
import AppKit

// Extend NSImage for converting to CGImage
extension NSImage {
   func asCGImage() -> CGImage? {
      if let imageData = self.tiffRepresentation,
         let sourceData = CGImageSourceCreateWithData(imageData as CFData, nil) {
         return CGImageSourceCreateImageAtIndex(sourceData, 0, nil)
      }
      return nil
   }
}

let validLangs = ["en-US", "fr-FR", "it-IT", "de-DE", "es-ES", "pt-BR", "zh-Hans", "zh-Hant"]

let arguments = CommandLine.arguments

if (arguments.count < 2 || arguments.count > 4) {
    print("Format: ./macOCR [filepath_to_image] [language_optional]")
    exit(0)
}

let filePath = arguments[1]
var language = "";
if (arguments.count == 3) {
    language = arguments[2]
}

if (arguments.count == 3 && !validLangs.contains(language)) {
    print("Could not recognize language. Here's the supported list:")
    
    do {
        print(try VNRecognizeTextRequest.supportedRecognitionLanguages(for: .accurate, revision: VNRecognizeTextRequestRevision2))
    }
    catch {
        print(["en-US"])
    }
    exit(0)
}

guard let img = NSImage.init(contentsOfFile: filePath)
else {
    print("Could not find image!")
    exit(0)
}

guard let cgImg = img.asCGImage()
else {
    print("Could not read image!")
    exit(0)
}

var requestHandler = VNImageRequestHandler(cgImage: cgImg, options: [:])
let request = VNRecognizeTextRequest { (request, error) in

    guard let observations = request.results as? [VNRecognizedTextObservation]
    else {
        print("Error with OCR!")
        exit(0)
    }

    let recognizedStrings = observations.compactMap { observation in
        return observation.topCandidates(1).first?.string
    }
    
    let confidenceLevels = observations.compactMap { observation in
        return observation.confidence
    }
    
    let boundingBoxes = observations.compactMap { observation in
        return observation.boundingBox
    }
    
    print("Recognized text:")
    print(recognizedStrings)
    print("Normalized bounding box:")
    print(boundingBoxes)
    print("Confidence:")
    print(confidenceLevels)
}

if (arguments.count == 3) {
    request.recognitionLanguages = [language]
}
else {
    request.recognitionLanguages = ["en-US"]
}
request.usesLanguageCorrection = true
request.recognitionLevel = VNRequestTextRecognitionLevel.accurate
try? requestHandler.perform([request])

exit(0)
