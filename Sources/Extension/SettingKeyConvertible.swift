import Foundation

protocol SettingKeyConvertible: class {
    associatedtype SettingKey: RawRepresentable where SettingKey: Hashable
}

extension SettingKeyConvertible where Self: NSObject, SettingKey.RawValue == String {
    func dictionaryWithValues(forKeys: [SettingKey]) -> [SettingKey: Any] {
        var values: [SettingKey: Any] = [:]
        let keyedValues = dictionaryWithValues(forKeys: forKeys.map { $0.rawValue })
        for (key, value) in keyedValues {
            guard let newKey = SettingKey(rawValue: key) else { continue }
            values[newKey] = value
        }
        return values
    }

    func setValuesForKeys(_ keyedValues: [SettingKey: Any]) {
        var values: [String: Any] = [:]
        for (key, value) in keyedValues {
            values[key.rawValue] = value
        }
        setValuesForKeys(values)
    }
}
