class Pricing {

  String serviceName;
  String price;
  String duration;
  String multiUser;
  String platform;

  Pricing({required this.serviceName, required this.price, required this.duration, required this.platform, required this.multiUser});

  factory Pricing.mapToJson(Map<String, dynamic> json) {
    return Pricing(
      serviceName: json['serviceName'],
      price: json['price'],
      duration: json['duration'],
      platform: json['platform'],
      multiUser: json['multiUser'],
    );
  }

}
