class DelegationModeState {
  final bool isActive;
  final String delegatorName;
  final String delegationTo;

  const DelegationModeState({
    required this.isActive,
    required this.delegatorName,
    required this.delegationTo,
  });

  const DelegationModeState.inactive()
      : isActive = false,
        delegatorName = '',
        delegationTo = '';
}
