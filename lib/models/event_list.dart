class EventList {
  int status;
  String message;
  List<Event>? data;

  EventList(this.status, this.message, this.data);
}

class Event {
  int? eventId;
  String? title;
  String? formLink;
  String? imageUrl;
  String? color;
  String? startTime;
  String? endTime;
  bool? isExpired;

  Event(this.eventId, this.title, this.formLink, this.imageUrl, this.color, this.startTime,
      this.endTime, this.isExpired);
}
