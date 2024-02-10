import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @ObservedObject var authController: AuthController

    var body: some View {
        NavigationView {
            ZStack {
                // 青のグラデーション
                LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    TextField("メールアドレス", text: $email)
                        .frame(width: 250.0, height: 60)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    SecureField("パスワード", text: $password)
                        .frame(width: 250.0, height: 60)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(action: {
                        authController.signIn(email: email, password: password)
                    }) {
                        Text("ログイン")
                            .frame(width: 250, height: 50)
                    }
                    .accentColor(Color.white)
                    .background(Color.black)
                    .cornerRadius(.infinity)

                    if authController.isAuthenticated {
                        // ログイン後のページに遷移
                        HelloPage(authController: authController)
                    }

                    // 新規登録画面への遷移ボタン
                    NavigationLink(destination: SignUpView(authController: authController)) {
                        Text("新規登録")
                            .foregroundColor(.white)
                            .padding(.top, 16)
                    }
                }
            }
        }
    }
}

// SignIn Preview
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(authController: AuthController())
    }
}
