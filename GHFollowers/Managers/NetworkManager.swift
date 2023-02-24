import UIKit


class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com/" // networkManager.shared. ile artık buna erişilemeyecek çümkü private var
    let cache = NSCache<NSString, UIImage>() // ????????
    
    private init() {}
    
    // result ile fail ve succes durumları yaptık
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = baseUrl + "users/\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            //completed(nil, .invalidUsername)
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                //completed(nil, .unableToComplete)
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                //completed(nil, .invalidResponse)
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                //completed(nil, .invalidData)
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                // completed(followers, nil) // ilk kısım gönderilicek şey, ikincisi error mesajı
                completed(.success(followers))
            } catch {
                //completed(nil, .invalidData)
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void) {
        let endpoint = baseUrl + "users/\(username)"
        
        guard let url = URL(string: endpoint) else {
            //completed(nil, .invalidUsername)
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                //completed(nil, .unableToComplete)
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                //completed(nil, .invalidResponse)
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                //completed(nil, .invalidData)
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                // completed(followers, nil) // ilk kısım gönderilicek şey, ikincisi error mesajı
                completed(.success(user))
            } catch {
                //completed(nil, .invalidData)
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
