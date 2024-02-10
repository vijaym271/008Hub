abstract class LoginEvent {
  const LoginEvent();
}

class Login extends LoginEvent {
  const Login();
}

class Logout extends LoginEvent {
  const Logout();
}
