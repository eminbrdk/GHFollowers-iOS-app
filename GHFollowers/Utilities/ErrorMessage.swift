import Foundation


enum GFError: String, Error { // .rawValue string ve error oldu
    // soldakiler key, sağdakiler raw value
    case invalidUsername = "This user created an invalaid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the serves was invalid. Plesa try again."
    case unableToFavorite = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "You have already favorited this user. You must realy like them!"
}
