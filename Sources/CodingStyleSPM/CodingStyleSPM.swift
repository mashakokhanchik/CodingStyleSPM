import Foundation

// MARK: - Line decoration
@propertyWrapper
public struct CodingStyleSPM {
    
    public enum Style: String {
        case camelCase = ""
        case snakeCase = "_"
        case kebabCase = "-"
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
    
    // MARK: - Inits
    
    public init(wrappedValue: String, style: Style) {
        self.value = wrappedValue
        self.style = style
    }
    
    // MARK: - Private methods
    
    private func get() -> String {
        return format(value)
    }
    
    private mutating func set(_ newValue: String) {
        self.value = newValue
    }
    
    private func format(_ string: String) -> String {
         var tmpString = string
            .replacingOccurrences(of: Style.snakeCase.rawValue, with: " ")
            .replacingOccurrences(of: Style.kebabCase.rawValue, with: " ")
            .lowercased()
        
        var array = tmpString
            .split(separator: " ")
            .map { String($0) }
        
        if style == .camelCase {
            array = array.map { $0.capitalized }
            if !array.isEmpty {
                array[0] = array[0].lowercased()
            }
        }
        
        tmpString = array.joined(separator: style.rawValue)
        return tmpString
    }
}
