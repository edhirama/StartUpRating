//  This file was automatically generated and should not be edited.

import Apollo

public final class GetAllSegmentsQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetAllSegments {\n  allSegments {\n    __typename\n    code\n    name\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allSegments", type: .list(.object(AllSegment.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allSegments: [AllSegment?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "allSegments": allSegments.flatMap { (value: [AllSegment?]) -> [ResultMap?] in value.map { (value: AllSegment?) -> ResultMap? in value.flatMap { (value: AllSegment) -> ResultMap in value.resultMap } } }])
    }

    public var allSegments: [AllSegment?]? {
      get {
        return (resultMap["allSegments"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [AllSegment?] in value.map { (value: ResultMap?) -> AllSegment? in value.flatMap { (value: ResultMap) -> AllSegment in AllSegment(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [AllSegment?]) -> [ResultMap?] in value.map { (value: AllSegment?) -> ResultMap? in value.flatMap { (value: AllSegment) -> ResultMap in value.resultMap } } }, forKey: "allSegments")
      }
    }

    public struct AllSegment: GraphQLSelectionSet {
      public static let possibleTypes = ["Segment"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("code", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(code: String, name: String) {
        self.init(unsafeResultMap: ["__typename": "Segment", "code": code, "name": name])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var code: String {
        get {
          return resultMap["code"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "code")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }
    }
  }
}

public final class GetAllStartupsQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetAllStartups {\n  allStartups {\n    __typename\n    ...StartupDetails\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(StartupDetails.fragmentDefinition) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allStartups", type: .list(.object(AllStartup.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allStartups: [AllStartup?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "allStartups": allStartups.flatMap { (value: [AllStartup?]) -> [ResultMap?] in value.map { (value: AllStartup?) -> ResultMap? in value.flatMap { (value: AllStartup) -> ResultMap in value.resultMap } } }])
    }

    public var allStartups: [AllStartup?]? {
      get {
        return (resultMap["allStartups"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [AllStartup?] in value.map { (value: ResultMap?) -> AllStartup? in value.flatMap { (value: ResultMap) -> AllStartup in AllStartup(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [AllStartup?]) -> [ResultMap?] in value.map { (value: AllStartup?) -> ResultMap? in value.flatMap { (value: AllStartup) -> ResultMap in value.resultMap } } }, forKey: "allStartups")
      }
    }

    public struct AllStartup: GraphQLSelectionSet {
      public static let possibleTypes = ["Startup"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(StartupDetails.self),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var startupDetails: StartupDetails {
          get {
            return StartupDetails(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public struct StartupDetails: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment StartupDetails on Startup {\n  __typename\n  name\n  description\n  imageUrl\n  Segment {\n    __typename\n    name\n    code\n  }\n}"

  public static let possibleTypes = ["Startup"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("description", type: .nonNull(.scalar(String.self))),
    GraphQLField("imageUrl", type: .nonNull(.scalar(String.self))),
    GraphQLField("Segment", type: .object(Segment.selections)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(name: String, description: String, imageUrl: String, segment: Segment? = nil) {
    self.init(unsafeResultMap: ["__typename": "Startup", "name": name, "description": description, "imageUrl": imageUrl, "Segment": segment.flatMap { (value: Segment) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  public var description: String {
    get {
      return resultMap["description"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "description")
    }
  }

  public var imageUrl: String {
    get {
      return resultMap["imageUrl"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "imageUrl")
    }
  }

  public var segment: Segment? {
    get {
      return (resultMap["Segment"] as? ResultMap).flatMap { Segment(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "Segment")
    }
  }

  public struct Segment: GraphQLSelectionSet {
    public static let possibleTypes = ["Segment"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("name", type: .nonNull(.scalar(String.self))),
      GraphQLField("code", type: .nonNull(.scalar(String.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(name: String, code: String) {
      self.init(unsafeResultMap: ["__typename": "Segment", "name": name, "code": code])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var name: String {
      get {
        return resultMap["name"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }

    public var code: String {
      get {
        return resultMap["code"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "code")
      }
    }
  }
}