class AddReview {
  final String id;
  final String name;
  final String review;

  AddReview({required this.id, required this.name, required this.review});

  factory AddReview.fromJson(Map<String, dynamic> json) =>
      AddReview(id: json["id"], name: json["name"], review: json["review"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "review": review};
}
