//
//  Untitled.swift
//  RxSwiftCitiesDemo
//
//  Created by Haidy Saeed on 15/01/2025.
//

import Foundation

// Define the City struct
struct CityDTO: Codable {
    let city: String
    let country: String
    let population: Int
    let capital: Bool
    let mostCommonTemp: Int
    
    // Coding keys to match JSON keys
    enum CodingKeys: String, CodingKey {
        case city, country, population, capital
        case mostCommonTemp = "most_common_temp"
    }
}


// JSON string (you can replace this with the actual JSON data)
let jsonString = """
[
  {
    "city": "Cairo",
    "country": "Egypt",
    "population": 9000000,
    "capital": true,
    "most_common_temp": 25
  },
  {
    "city": "Alexandria",
    "country": "Egypt",
    "population": 5000000,
    "capital": false,
    "most_common_temp": 22
  },
  {
    "city": "Giza",
    "country": "Egypt",
    "population": 2000000,
    "capital": false,
    "most_common_temp": 26
  },
  {
    "city": "Sharm El Sheikh",
    "country": "Egypt",
    "population": 73000,
    "capital": false,
    "most_common_temp": 30
  },
  {
    "city": "Luxor",
    "country": "Egypt",
    "population": 500000,
    "capital": false,
    "most_common_temp": 28
  },
  {
    "city": "Paris",
    "country": "France",
    "population": 2000000,
    "capital": true,
    "most_common_temp": 12
  },
  {
    "city": "Marseille",
    "country": "France",
    "population": 860000,
    "capital": false,
    "most_common_temp": 17
  },
  {
    "city": "Lyon",
    "country": "France",
    "population": 500000,
    "capital": false,
    "most_common_temp": 14
  },
  {
    "city": "Toulouse",
    "country": "France",
    "population": 490000,
    "capital": false,
    "most_common_temp": 16
  },
  {
    "city": "Nice",
    "country": "France",
    "population": 340000,
    "capital": false,
    "most_common_temp": 19
  },
  {
    "city": "New York City",
    "country": "USA",
    "population": 8000000,
    "capital": false,
    "most_common_temp": 13
  },
  {
    "city": "Los Angeles",
    "country": "USA",
    "population": 4000000,
    "capital": false,
    "most_common_temp": 18
  },
  {
    "city": "Chicago",
    "country": "USA",
    "population": 2700000,
    "capital": false,
    "most_common_temp": 10
  },
  {
    "city": "San Francisco",
    "country": "USA",
    "population": 875000,
    "capital": false,
    "most_common_temp": 15
  },
  {
    "city": "Houston",
    "country": "USA",
    "population": 2300000,
    "capital": false,
    "most_common_temp": 20
  },
  {
    "city": "Rome",
    "country": "Italy",
    "population": 2800000,
    "capital": true,
    "most_common_temp": 15
  },
  {
    "city": "Milan",
    "country": "Italy",
    "population": 1300000,
    "capital": false,
    "most_common_temp": 12
  },
  {
    "city": "Florence",
    "country": "Italy",
    "population": 380000,
    "capital": false,
    "most_common_temp": 14
  },
  {
    "city": "Venice",
    "country": "Italy",
    "population": 260000,
    "capital": false,
    "most_common_temp": 13
  },
  {
    "city": "Naples",
    "country": "Italy",
    "population": 960000,
    "capital": false,
    "most_common_temp": 17
  },
  {
    "city": "Cape Town",
    "country": "South Africa",
    "population": 4000000,
    "capital": true,
    "most_common_temp": 16
  },
  {
    "city": "Johannesburg",
    "country": "South Africa",
    "population": 5000000,
    "capital": false,
    "most_common_temp": 19
  },
  {
    "city": "Durban",
    "country": "South Africa",
    "population": 3500000,
    "capital": false,
    "most_common_temp": 21
  },
  {
    "city": "Pretoria",
    "country": "South Africa",
    "population": 750000,
    "capital": true,
    "most_common_temp": 17
  },
  {
    "city": "Port Elizabeth",
    "country": "South Africa",
    "population": 1300000,
    "capital": false,
    "most_common_temp": 18
  },
  {
    "city": "Rabat",
    "country": "Morocco",
    "population": 580000,
    "capital": true,
    "most_common_temp": 19
  },
  {
    "city": "Casablanca",
    "country": "Morocco",
    "population": 3500000,
    "capital": false,
    "most_common_temp": 20
  },
  {
    "city": "Marrakech",
    "country": "Morocco",
    "population": 1000000,
    "capital": false,
    "most_common_temp": 24
  },
  {
    "city": "Fez",
    "country": "Morocco",
    "population": 1100000,
    "capital": false,
    "most_common_temp": 18
  },
  {
    "city": "Tangier",
    "country": "Morocco",
    "population": 1000000,
    "capital": false,
    "most_common_temp": 21
  }
]
"""

// Convert the JSON string to Data

