class Trips {
  String? id;
  String? source;
  String? destination;
  DateTime? time;
  String? UserId;

  Trips({
    this.id,
    this.source,
    this.destination,
    this.time,
    this.UserId,
  });

  Trips.fromJson(Map<String, dynamic> data)
      : id = data["id"],
        source = data["source"],
        destination = data['destination'],
        time = data['time'],
        UserId = data['UserId'];
}
