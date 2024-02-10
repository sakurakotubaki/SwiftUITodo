import SwiftUI

struct SignUpView: View {
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
                    TextField("Email", text: $email)
                        .frame(width: 250.0, height: 60)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Password", text: $password)
                        .frame(width: 250.0, height: 60)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        authController.signUp(email: email, password: password)
                    }) {
                        Text("新規登録")
                            .frame(width: 250, height: 50)
                    }
                    .accentColor(Color.white)
                    .background(Color.black)
                    .cornerRadius(.infinity)
                    
                    if authController.isAuthenticated {
                        // ログイン後のページに遷移
                        if authController.isAuthenticated {
                            HelloPage(authController: authController)
                        }
                        
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
    }}
