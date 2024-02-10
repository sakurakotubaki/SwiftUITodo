import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
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
                        if email.isValidEmail && password.isValidPassword {
                            authController.signUp(email: email, password: password)
                        } else {
                            // ユーザーにエラーメッセージを表示します。
                            alertMessage = "メールアドレスまたはパスワードが無効です。"
                            showingAlert = true
                        }
                    }) {
                        Text("新規登録")
                            .frame(width: 250, height: 50)
                    }
                    .accentColor(Color.white)
                    .background(Color.black)
                    .cornerRadius(.infinity)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("エラー"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                    
                    if authController.isAuthenticated {
                        // ログイン後のページに遷移
                        HelloPage(authController: authController)
                    }
                }
            }
        }
    }
    
    // SignIn Preview
    struct SignUpView_Previews: PreviewProvider {
        static var previews: some View {
            SignUpView(authController: AuthController())
        }
    }
}
    
    // SignIn Preview
    struct SignUpView_Previews: PreviewProvider {
        static var previews: some View {
            SignUpView(authController: AuthController())
        }
    }
