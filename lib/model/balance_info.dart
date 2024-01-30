class BalanceInfo {
  int? proPlanCredit;
  int? maxPlanCredit;
  int? proExtraCredit;
  int? maxExtraCredit;
  int? nextPlanRefreshTime;

  BalanceInfo(
      {this.proPlanCredit,
      this.maxPlanCredit,
      this.proExtraCredit,
      this.maxExtraCredit,
      this.nextPlanRefreshTime});

  BalanceInfo.fromJson(Map<String, dynamic> json) {
    proPlanCredit = json['proPlanCredit'];
    maxPlanCredit = json['maxPlanCredit'];
    proExtraCredit = json['proExtraCredit'];
    maxExtraCredit = json['maxExtraCredit'];
    nextPlanRefreshTime = json['nextPlanRefreshTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['proPlanCredit'] = proPlanCredit;
    data['maxPlanCredit'] = maxPlanCredit;
    data['proExtraCredit'] = proExtraCredit;
    data['maxExtraCredit'] = maxExtraCredit;
    data['nextPlanRefreshTime'] = nextPlanRefreshTime;
    return data;
  }
}
