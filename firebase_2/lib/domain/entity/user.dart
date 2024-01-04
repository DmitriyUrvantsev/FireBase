class UserApp {
  final String uid;

  UserApp({
    required this.uid,
  });
}

class UserAppData {
  final String uid;
  final String name;
  final String? chisburger;
  final String? bigMac;
  final String? kartoshka;
  final String? cola;

  UserAppData({
    required this.uid,
    required this.name,
    required this.chisburger,
    required this.bigMac,
    required this.kartoshka,
    required this.cola,
  });
}
