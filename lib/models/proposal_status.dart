enum ProposalStatus {
  waiting(0),
  active(1),
  offer(2),
  hired(3);

  final int flag;

  const ProposalStatus(this.flag);

  static ProposalStatus fromFlag(int flag) {
    return switch (flag) {
      1 => active,
      2 => offer,
      3 => hired,
      _ => waiting
    };
  }
}