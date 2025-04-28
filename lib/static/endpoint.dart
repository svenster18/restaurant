enum Endpoint {
  smallImage("$_baseUrl/images/small/"),
  mediumImage("$_baseUrl/images/medium/"),
  largeImage("$_baseUrl/images/large/");

  const Endpoint(this.url);
  final String url;

  static const _baseUrl = "https://restaurant-api.dicoding.dev";
}