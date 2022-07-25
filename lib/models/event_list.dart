class EventList {
  EventList(this.status, this.message, this.data);

  int status;
  String message;
  List<Event> data;
}

class Event {
  Event(this.eventId, this.title, this.formLink, this.imageUrl, this.color,
      this.startTime, this.endTime, this.isExpired);

  int eventId;
  String title;
  String formLink;
  String imageUrl;
  String color;
  String startTime;
  String endTime;
  bool isExpired;

  factory Event.fromJson(Map<String, dynamic> jsonData) {
    return Event(
        jsonData["eventId"],
        jsonData["title"],
        jsonData["formLink"],
        jsonData["imageUrl"],
        jsonData["color"],
        jsonData["startTime"],
        jsonData["endTime"],
        jsonData["isExpired"]);
  }
}
