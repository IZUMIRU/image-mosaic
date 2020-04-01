import Cocoa
import CoreImage

let pb = NSPasteboard.general;
let readData = pb.data(forType: NSPasteboard.PasteboardType.tiff)

if( readData == nil ){
  print("クリップボードへ写真・画像をコピーしてください。")
  exit(1)
}

let filter = CIFilter(name: "CIGaussianBlur")
let cbImage = CIImage(data: readData!)
let mosaic = 10.0; // 数値が大きいほどモザイク強

filter?.setDefaults()
filter?.setValue(cbImage, forKey: "inputImage")
filter?.setValue(mosaic, forKey: "inputRadius")

let outputImage = filter?.outputImage
let cropRect = CGRect(origin: CGPoint(x: 0, y: 0), size: cbImage!.extent.size)
let bmImage = NSBitmapImageRep(ciImage: outputImage!.cropped(to: cropRect))

pb.clearContents();
pb.setData(bmImage.tiffRepresentation!, forType: NSPasteboard.PasteboardType.tiff)

print("完了")
