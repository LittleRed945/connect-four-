enum Turn {
    case yellow
    case red
    mutating func Text_of_Turn()->String{
        switch self {
        case .yellow:
            return "yellow"
        default:
            return "red"
        }
    }
    mutating func change_turn(){
        switch self {
        case .yellow:
            self = .red
        default:
            self = .yellow
        }
    }
}

