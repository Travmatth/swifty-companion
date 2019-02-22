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

struct User: Decodable {
  let email: String?
  let login: String?
  let phone: String?
  let imageUrl: URL?
  let correctionPoint: Int?
  let wallet: Int?
  let cursusUsers: [CursusUsersJSON]?
  let projectsUsers: [ProjectsJSON]?
  private enum CodingKeys: String, CodingKey {
	  case email
	  case login
	  case phone
	  case imageUrl = "image_url"
	  case correctionPoint = "correction_point"
	  case wallet
	  case cursusUsers = "cursus_users"
	  case projectsUsers = "projects_users"
  }
}

func parseUserData(data: Data) -> User? {
    do {
        let decoder = JSONDecoder()
        let user = try decoder.decode(User.self, from: data)
        return user
    } catch {
        print("Error parsing user data json: \(error)")
        return nil
    }
}

func parseLevel(model: User?) -> String {
    var level = "Unavailable"
        for user in (model?.cursusUsers)! {
        if user.cursus?.name == "42" && user.level != nil {
            level = "Level: \(String(describing: user.level!))"
            break
        }
    }
    return level
}
