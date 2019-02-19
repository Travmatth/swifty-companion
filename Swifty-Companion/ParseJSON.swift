//
//  ParseJSON.swift
//  Swifty-Companion
//
//  Created by Travis Matthews on 2/18/19.
//  Copyright © 2019 Travis Matthews. All rights reserved.
//

import Foundation

struct SkillsJSON: Decodable {
  let id: Int?
  let name: String?
  let level: Float?
}

struct UserJSON: Decodable {
  let id: Int?
  let login: String??
  let url: URL?
}

struct CursusJSON: Decodable {
  let id: Int?
  let createdAt: String?
  let name: String?
  let slug: String?
  private enum CodingKeys: String, CodingKey {
    case id
    case createdAt = "created_at"
    case name
    case slug
  }
}

struct CursusUsersJSON: Decodable {
  let grade: String?
  let level: Float?
  let skills: [SkillsJSON]?
  let id: Int?
  let beginAt: String?
  let endAt: String?
  let cursusId: Int?
  let hasCoalition: Bool?
  let user: UserJSON?
  let cursus: CursusJSON?
  private enum CodingKeys: String, CodingKey {
    case grade
    case level
    case skills
    case id
    case beginAt = "begin_at"
    case endAt = "end_at"
    case cursusId = "cursus_id"
    case hasCoalition = "has_coalition"
    case user
    case cursus
  }
}

struct ProjectJSON: Decodable {
  let id: Int?
  let name: String?
  let slug: String?
  let parentId: Int?
  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case slug
    case parentId = "parent_id"
  }
}

struct ProjectsJSON: Decodable {
  let id: Int?
  let occurrence: Int?
  let finalMark: Int?
  let status: String??
  let validated: Bool?
  let currentTeamId: Int?
  let project: ProjectJSON?
  let cursusIds: [Int]?
  let markedAt: String?
  let marked: Bool?
  private enum CodingKeys: String, CodingKey {
    case id
    case occurrence
    case finalMark = "final_mark"
    case status
    case validated
    case currentTeamId = "current_team_id"
    case project
    case cursusIds = "cursus_ids"
    case markedAt = "marked_at"
    case marked
  }
}

struct AchievementsJSON: Decodable {
  let id: Int?
  let name: String?
  let description: String?
  let tier: String?
  let kind: String?
  let visible: Bool?
  let image: String?
  let nbrOfSuccess: Int?
  let usersUrl: URL?
  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case description
    case tier
    case kind
    case visible
    case image
    case nbrOfSuccess = "nbr_of_success"
    case usersUrl = "users_url"
  }
}

struct LanguageJSON: Decodable {
  let id: Int?
  let name: String?
  let identifier: String?
  let createdAt: String?
  let updatedAt: String?
  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case identifier
    case createdAt = "created_at"
    case updatedAt = "updated_at"
  }
}

struct CampusJSON: Decodable {
  let id: Int?
  let name: String?
  let timeZone: String?
  let language: LanguageJSON?
  let usersCount: Int?
  let vogsphereId: Int?
  let country: String?
  let address: String?
  let zip: String?
  let city: String?
  let website: URL?
  let facebook: URL?
  let twitter: URL?
  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case timeZone = "time_zone"
    case language
    case usersCount = "users_count"
    case vogsphereId = "vogsphere_id"
    case country
    case address
    case zip
    case city
    case website
    case facebook
    case twitter
  }
}
struct CampusUsersJSON: Decodable {
  let id: Int?
  let userId: Int?
  let campusId: Int?
  let isPrimary: Bool?
  private enum CodingKeys: String, CodingKey {
    case id
    case userId = "user_id"
    case campusId = "campus_id"
    case isPrimary = "is_primary"
  }
}

struct User: Decodable {
  let id: Int?
  let email: String?
  let login: String?
  let firstName: String?
  let lastName: String?
  let url: URL?
  let phone: String?
  let displayname: String?
  let imageUrl: URL?
  let staff: Bool?
  let correctionPoint: Int?
  let poolMonth: String?
  let poolYear: String?
  let location: String?
  let wallet: Int?
  let groups: [String]?
  let cursusUsers: [CursusUsersJSON]?
  let projectsUsers: [ProjectsJSON]?
  let achievements: [AchievementsJSON]?
  let titles: [String]?
  let titlesUsers: [String]?
  let partnerships: [String]?
  let patroned: [String]?
  let patroning: [String]?
  let expertisesUsers: [String]?
  let campus: [CampusJSON]?
  let campusUsers: [CampusUsersJSON]?
  private enum CodingKeys: String, CodingKey {
	  case id
	  case email
	  case login
	  case firstName = "first_name"
	  case lastName = "last_name"
	  case url
	  case phone
	  case displayname
	  case imageUrl = "image_url"
	  case staff = "staff?"
	  case correctionPoint = "correction_point"
	  case poolMonth = "pool_month"
	  case poolYear = "pool_year"
	  case location
	  case wallet
	  case groups
	  case cursusUsers = "cursus_users"
	  case projectsUsers = "projects_users"
	  case achievements
	  case titles
	  case titlesUsers = "titles_users"
	  case partnerships
	  case patroned
	  case patroning
	  case expertisesUsers = "expertises_users"
	  case campus
	  case campusUsers = "campus_users"
  }
}

func parseUserData(data: Data) -> User? {
    do {
        let decoder = JSONDecoder()
        let user = try decoder.decode(User.self, from: data)
        return user
    } catch {
        print("Error parsing user data json")
        return nil
    }
}
