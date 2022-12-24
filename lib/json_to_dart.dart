class OfferedShifts {
  List<Offer>? offers;

  OfferedShifts({this.offers});

  OfferedShifts.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      offers = <Offer>[];
      json['data'].forEach((v) {
        offers!.add(new Offer.fromJson(v));
      });
    }
  }
}

class Offer {
  int? id;
  String? status;
  DateTime? startAt;
  DateTime? endAt;
  String? postName;
  int? postId;
  bool? startSoon;
  Recurring? recurring;
  String? company;
  String? buyPrice;
  int? bonus;
  double? latitude;
  double? longitude;

  Offer({this.id, this.status, this.startAt, this.endAt, this.postName, this.postId, this.startSoon, this.recurring, this.company, this.buyPrice, this.bonus, this.latitude, this.longitude});

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    startAt = DateTime.parse(json['start_at']);
    endAt = DateTime.parse(json['end_at']);
    postName = json['post_name'];
    postId = json['post_id'];
    startSoon = json['start_soon'];
    recurring = json['recurring'] != null ? new Recurring.fromJson(json['recurring']) : null;
    company = json['company'];
    buyPrice = json['buy_price'];
    bonus = json['bonus'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
}

class Recurring {
  int? id;
  DateTime? startAt;
  DateTime? endAt;
  bool? isAvailable;

  Recurring({this.id, this.startAt, this.endAt, this.isAvailable});

  Recurring.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startAt = DateTime.parse(json['start_at']);
    endAt = DateTime.parse(json['end_at']);
    isAvailable = json['is_available'];
  }
}
