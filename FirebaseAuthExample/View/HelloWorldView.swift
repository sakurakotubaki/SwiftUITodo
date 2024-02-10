import SwiftUI

// ログイン後の画面
struct HelloPage: View {
    var authController: AuthController

    var body: some View {
        VStack {
            Text("Hello, you're logged in!")
                .font(.title)
                .padding()
            
            Button(action: {
                // ログアウトしてログイン画面へ遷移する
                authController.signOut()
            }) {
                Text("ログアウト")
                    .frame(width: 250, height: 50)
            }
            .accentColor(Color.white)
            .background(Color.pink)
            .cornerRadius(.infinity)
        }
    }
}

struct HelloWorldView_Previews: PreviewProvider {
    static var previews: some View {
        HelloPage(authController: AuthController())
    }
}
