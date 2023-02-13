class JoksData {
  final String? createddate;
  final String? value;

  JoksData({
    required this.createddate,
    required this.value,
  });

  factory JoksData.fromJson({required Map data}) {
    return JoksData(
      createddate: data["created_at"],
      value: data["value"],
    );
  }
}