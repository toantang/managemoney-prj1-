class Deal {
  int _id;
  String _nameDeal;
  String _groupNameDeal;
  double _moneyDeal;
  int _dateDeal;

  Deal({int id: 0, String nameDeal: "no name", String groupNameDeal: "no group name", double moneyDeal: 0.0, int dateDeal: 0, })
  {
    this._id = id;
    this._nameDeal = nameDeal;
    this._groupNameDeal = groupNameDeal;
    this._moneyDeal = moneyDeal;
    this._dateDeal = dateDeal;
  }

  static Deal deal = new Deal(id: 0, nameDeal: "no name", groupNameDeal: 'no group name', moneyDeal: 0.0, dateDeal: 0);

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  double get moneyDeal => _moneyDeal;

  set moneyDeal(double value) {
    _moneyDeal = value;
  }

  String get nameDeal => _nameDeal;

  int get dateDeal => _dateDeal;

  set dateDeal(int value) {
    _dateDeal = value;
  }

  set nameDeal(String value) {
    _nameDeal = value;
  }

  String get groupNameDeal => _groupNameDeal;

  set groupNameDeal(String value) {
    _groupNameDeal = value;
  }
}