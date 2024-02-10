import Foundation

extension String {
    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }

    var isValidPassword: Bool {
        // 6文字以上であることを確認します。より複雑なパスワード要件に変更することができます。
        return self.count >= 6
    }
}
