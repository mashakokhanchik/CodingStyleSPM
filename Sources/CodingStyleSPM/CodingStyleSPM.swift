import Foundation

// MARK: - Line decoration
@propertyWrapper
public struct CodingStyleSPM {
    
    public enum Style: String {
        case camelCase, snakeCase, kebabCase
    }
    
    // MARK: - Properties
    
    private var value : String
    private var style: Style
    public var wrappedValue: String {
        get {
            get()
        }
        set {
            set(newValue)
        }
    }
    
    private static let codingCase: [Style: (String) -> String] = [
        .camelCase: { value in
            let value = value.lowercased()
                .split(separator: " ")
                .drop { $0.isEmpty }
                .map { $0.prefix(1).uppercased()+$0.dropFirst() }
                .joined()
            return value.prefix(1).lowercased()+value.dropFirst()
        },
        .snakeCase: { value in
            value.lowercased()
                .split(separator: " ")
                .drop { $0.isEmpty }
                .joined(separator: "-")
        },
        .kebabCase: { value in value.lowercased()
                .split(separator: " ")
                .drop { $0.isEmpty }
                .joined(separator: "_")
        }
    ]
    
    // MARK: - Inits
    
    public init(wrappedValue: String, style: Style) {
        self.value = wrappedValue
        self.style = style
    }
    
    // MARK: - Private methods
    
    private func get() -> String {
        guard let coding = CodingStyleSPM.codingCase[style] else { return value }
        return coding(value)
    }
    
    private mutating func set(_ newValue: String) {
        self.value = newValue
    }

}
