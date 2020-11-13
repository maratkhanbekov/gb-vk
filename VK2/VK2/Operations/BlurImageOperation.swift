import UIKit

class BlurImageOperation: Operation {
    let inputImage: UIImage
    var outputImage: UIImage?
    
    init(inputImage: UIImage) {
        self.inputImage = inputImage
        super.init()
    }
    
    override func main() {
        outputImage = makeBlur()
    }
    
    private func makeBlur() -> UIImage {
        let inputCIIimage = CIImage(image: inputImage)
        let blurFilter = CIFilter(name: "CIGaussianBlur", parameters: [kCIInputImageKey: inputCIIimage])
        let outputImage = blurFilter!.outputImage!
        
        let context = CIContext()
        let cgImage = context.createCGImage(outputImage, from: outputImage.extent)!
        return UIImage(cgImage: cgImage)
    }
}
