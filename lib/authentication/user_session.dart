abstract class UserSession {}

class SessionFound extends UserSession {
  final String fUID;

  SessionFound(this.fUID);
}

class SessionNotFound extends UserSession {}
