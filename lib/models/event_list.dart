class EventList {
  EventList(this.status, this.message, this.data);

  int status;
  String message;
  List<Event> data;
}

class Event {
  Event(this.eventId, this.title, this.formLink, this.imageUrl,
      this.startTime, this.endTime, this.eventStatus);

  int eventId;
  String title;
  String formLink;
  String imageUrl;
  String startTime;
  String endTime;
  String eventStatus;

  factory Event.fromJson(Map<String, dynamic> jsonData) {
    return Event(
        jsonData["eventId"],
        jsonData["title"],
        jsonData["formLink"],
        jsonData["imageUrl"],
        jsonData["startTime"],
        jsonData["endTime"],
        jsonData["eventStatus"]);
  }
}
