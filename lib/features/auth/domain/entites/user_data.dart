class UserData {
  final String name;
  final String accountType;
  final String email;

  UserData({
    required this.name,
    required this.accountType,
    required this.email,
  });

  bool get canUpload {
    final items = ["teacher", "admin"];
    return items.contains(accountType);
  }

  bool get canManageFiles {
    final items = ["teacher", "admin"];
    return items.contains(accountType);
  }

  bool get canManageCategories {
    final items = ["admin"];
    return items.contains(accountType);
  }
}
