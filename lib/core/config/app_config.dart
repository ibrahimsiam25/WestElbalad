/// App flavor — controls which bottom nav bar (and role-specific screens)
/// are shown at runtime.
///
/// Set [AppConfig.flavor] in your entry-point file before calling [runApp]:
///   • `main_admin.dart`  → AppConfig.flavor = AppFlavor.admin;
///   • `main_user.dart`   → AppConfig.flavor = AppFlavor.user;
enum AppFlavor { admin, user }

class AppConfig {
  AppConfig._();

  /// Current running flavor. Defaults to [AppFlavor.user].
  static AppFlavor flavor = AppFlavor.user;

  static bool get isAdmin => flavor == AppFlavor.admin;
  static bool get isUser => flavor == AppFlavor.user;
}
