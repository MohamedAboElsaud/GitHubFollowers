//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by mohamed ahmed on 13/09/2023.
//

import Foundation
enum ErrorMessage: String, Error{
    case invalidUsername    = "This username is an invalid .Please try again."
    case unableToComplete   = "unable to complete your request. Please check your internet connection."
    case invalidResponse    = "Invalid response from the server. Please try again"
    case invalidData        = "The data received from the server was invalid. Please try again."
    case unableToFavorites  = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "You have already favorited this user 😀."
    
}
