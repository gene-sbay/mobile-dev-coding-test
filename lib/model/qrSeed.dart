class QrSeed {
  final String seed;

  QrSeed({this.seed});

  factory QrSeed.fromJson(Map<String, dynamic> json) {
    return QrSeed(seed: json['seed']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seed'] = this.seed;
    return data;
  }

  @override
  String toString() {
    return 'QrSeed{seed: $seed}';
  }
}
