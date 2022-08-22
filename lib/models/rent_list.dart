class RentList {
  RentList(this.status, this.message, this.data);

  int status;
  String message;
  List<Rent> data;
}

class Rent {
  Rent(
      this.rentId,
      this.account,
      this.purpose,
      this.rentStatus,
      this.itemCategory,
      this.startTime,
      this.endTime,
      this.createdAt,
      this.updatedAt);

  int rentId;
  int account;
  String purpose;
  String rentStatus;
  String itemCategory;
  String startTime;
  String endTime;
  String createdAt;
  String updatedAt;

  factory Rent.fromJson(Map<String, dynamic> jsonData) {
    return Rent(
        jsonData["rentId"],
        jsonData["account"],
        jsonData["purpose"],
        jsonData["rentStatus"],
        jsonData["itemCategory"],
        jsonData["startTime"],
        jsonData["endTime"],
        jsonData["createdAt"],
        jsonData["updatedAt"]);
  }
}
