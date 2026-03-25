import Foundation
import Security

enum KeychainHelper {
    @discardableResult
    static func save(_ value: Int, forKey key: String) -> Bool {
        let data = withUnsafeBytes(of: value) { Data($0) }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecAttrService as String: "com.damla.mysticqueen",
        ]

        // Delete existing
        SecItemDelete(query as CFDictionary)

        // Add new
        var addQuery = query
        addQuery[kSecValueData as String] = data
        let status = SecItemAdd(addQuery as CFDictionary, nil)
        return status == errSecSuccess
    }

    static func load(forKey key: String) -> Int? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecAttrService as String: "com.damla.mysticqueen",
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne,
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess, let data = result as? Data, data.count == MemoryLayout<Int>.size else {
            return nil
        }

        return data.withUnsafeBytes { $0.load(as: Int.self) }
    }

    static func delete(forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecAttrService as String: "com.damla.mysticqueen",
        ]
        SecItemDelete(query as CFDictionary)
    }
}
