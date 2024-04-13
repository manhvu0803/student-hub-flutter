enum UserRole {
  student(0),
  company(1),
  admin(2),
  manager(3);

  final int flag;

  const UserRole(this.flag);

  static UserRole fromFlag(int flag) {
    return switch (flag) {
      1 => company,
      2 => admin,
      3 => manager,
      _ => student
    };
  }
}