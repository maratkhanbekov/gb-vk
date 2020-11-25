import UIKit
import CoreGraphics

// Класс для генерации изображения в глобальном потоке
class AsyncImageView: UIImageView {
    private var _image: UIImage?
    override var image: UIImage? {
        get {
            return _image
        }
        set {
            // Сохраняем изображение в _image
            _image = newValue
            // Сбрасываем содержимое поля
            layer.contents = nil
            // Проверяем не пустое ли новое значение
            guard let image = newValue else { return }
            
            DispatchQueue.global(qos: .userInitiated).async {
                // Выносим операцию декодирования в глобальную очередь
                let decodedCGImage = self.decode(image)
                
                // Обновляем интерфейс в главном потоке
                DispatchQueue.main.async {
                    self.layer.contents = decodedCGImage
                }
            }
        }
    }
    
    private func decode(_ image: UIImage) -> CGImage? {
        // Конвертируем входящий UImage в CoreGraphics Image
        guard let newImage = image.cgImage else { return nil }
        
        // Проверяем кэш на наличие декодированного CGImage
        if let cachedImage = AsyncImageView.cache.object(forKey: image) {
            return (cachedImage as! CGImage)
        }
        
        // Создаем цветовое пространство для рендеринга
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // Создаем "чистый" графический контекст
        let context = CGContext(data: nil, width: newImage.width, height: newImage.height, bitsPerComponent: 8, bytesPerRow: newImage.width * 4, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)
        
        // Рассчитываем cornerRadius для закругления
        let imgRect = CGRect(x: 0, y: 0, width: newImage.width, height: newImage.height)
        let maxDimension = CGFloat(max(newImage.width, newImage.height))
        let cornerRadiusPath = UIBezierPath(roundedRect: imgRect, cornerRadius: maxDimension / 2).cgPath
        context?.addPath(cornerRadiusPath)
        context?.clip()
        
        // Рисуем изображение в контекст
        context?.draw(newImage, in: CGRect(x: 0, y: 0, width: newImage.width, height: newImage.height))
        
        // Проверяем успешно ли был создан CGImage
        guard let drawnImage = context?.makeImage() else { return nil }
        
        // Если успешно, то записываем в кэш
        AsyncImageView.cache.setObject(drawnImage, forKey: image)
        
        // Возвращаем созданное изображение
        return drawnImage
    }
}

// Расширение для кэширования изображений
extension AsyncImageView {
    private struct Cache {
        static var instance = NSCache<AnyObject, AnyObject>()
    }
    
    class var cache: NSCache<AnyObject, AnyObject> {
        get { return Cache.instance }
        set { Cache.instance = newValue }
    }
}
