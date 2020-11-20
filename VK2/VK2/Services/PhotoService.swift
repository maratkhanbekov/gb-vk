import Foundation
import Alamofire

class PhotoService {
    
    // Устанавливаем время, через которое обновим закешированный файл
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    
    // Словарь ссылок и самих изображений
    private var images: [String: UIImage] = [:]
    
    // Переменная с путем до папки с изображениями
    private static let pathName: String = {
        let pathName = "images"
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        
        // Если папки нет, то создаем
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return pathName
    }()
    
    
    // Создаем путь до файла
    private func getFilePath(url: String) -> String? {
        
        // Указатель на папку
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        // Парсим ссылку и берем название файла
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }
    
    // Сохраняем изображение
    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
    // Функция для получения изображения из кеша по ссылке
    private func getImageFromCache(url: String) -> UIImage? {
        guard
            let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName) else { return nil }
        
        // Обновляем словарь
        DispatchQueue.main.async {
            self.images[url] = image
        }
            return image
    }
    
    
    // Функция для скачивания и сохранения фото в кэш
    private func loadPhoto(url: String, completion: @escaping(UIImage) -> Void) {
        
        // В глобальной очереди распаковываем ссылку
        DispatchQueue.global().async {
            
            if let urlObject = URL(string: url) {
                if let data = try? Data(contentsOf: urlObject) {
                    if let image = UIImage(data: data) {

                        // Если распаковали, то запускаем closure
                        DispatchQueue.main.async {
                            completion(image)
                        }
                        
                        // А уже потом сохраняем в класс и кэш
                        self.images[url] = image
                        self.saveImageToCache(url: url, image: image)
                     }
                }
            }
            
            else {
                completion(UIImage())
            }
        }
    }
    
    // Функция-управление поиском фотографии
    func photo(url: String, completion: @escaping(UIImage) -> Void) {
        // Ищем в текущем классе
        if let photo = images[url] {
            debugPrint("Фото взяли из класса")
            completion(photo)
        // Ищем в кеше
        } else if let photo = getImageFromCache(url: url) {
            debugPrint("Фото взяли из кэша")
            completion(photo)
        } else {
        // Если не нашли, то скачиваем
            debugPrint("Фото скачали")
            loadPhoto(url: url, completion: completion)
        }
    }
}
