class RentList {
  RentList(this.status, this.message, this.data);

  int status;
  String message;
  List<Rent> data;
}

class Rent {
  Rent(this.rentId, this.itemCategory,
      this.startTime, this.endTime, this.amount, this.rentStatus);

  int rentId;
  String itemCategory;
  String startTime;
  String endTime;
  int amount;
  String rentStatus;

  factory Rent.fromJson(Map<String, dynamic> jsonData) {
    return Rent(
        jsonData["rentId"],
        jsonData["itemCategory"],
        jsonData["startTime"],
        jsonData["endTime"],
        jsonData["amount"],
        jsonData["rentStatus"]);
  }
}
