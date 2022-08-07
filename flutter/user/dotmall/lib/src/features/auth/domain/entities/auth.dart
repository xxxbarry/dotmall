class Auth {
  final Token token;
  final User user;
  const Auth({
    required this.token,
    required this.user,
  });
}

class User {}

class Token {
  final String token;
  final TokenType type;
  const Token({
    required this.token,
    this.type = TokenType.bearer,
  });
}

enum TokenType { bearer }
