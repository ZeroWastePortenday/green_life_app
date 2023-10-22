enum IsNewUser {
  isNew(0), // 0
  isNotNew(1); // 1

  const IsNewUser(this.status);
  final int status;

  static IsNewUser fromStatus(int status) {
    switch (status) {
      case 0:
        return IsNewUser.isNew;
      case 1:
        return IsNewUser.isNotNew;
      default:
        throw Exception('Unknown IsNewUser status : $status');
    }
  }
}


