class Moview {

  Moview({required this.title, required this.dateTime, required this.review, required this.rate});

  String title;
  String dateTime;
  String review;
  double rate;

  Moview.fromJson(Map<String, dynamic> json)
      :title = json['title'],
        dateTime = json['datetime'],
        review = json['review'],
        rate = json['rate'];


  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'datetime': dateTime,
      'review': review,
      'rate': rate
    };
  }

}