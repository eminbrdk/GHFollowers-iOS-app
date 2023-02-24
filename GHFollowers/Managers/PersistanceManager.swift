import Foundation

enum PersistanveActionType {
    case add, remove
}

enum PersistanceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    // verileri ekleyip sildik
    static func updateWith(favorite: Follower, actionType: PersistanveActionType, completed: @escaping (GFError?) -> Void) {
        retreiveFavorites { result in
            switch result {
            case .success(let favorites):
                var retreivedFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retreivedFavorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    
                    retreivedFavorites.append(favorite)
                    
                case .remove:
                    retreivedFavorites.removeAll { $0 == favorite }
                }
                
                completed(save(favorites: retreivedFavorites))
                
            case .failure(let errorMessage):
                completed(errorMessage)
            }
        }
    }
    
    // verileri aldık
    static func retreiveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        
        // as? yaptık çünkü veilecek olan veri Any? idi. Data yaptık onu
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    //verileri kaydettik
    static func save(favorites: [Follower]) -> GFError? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
