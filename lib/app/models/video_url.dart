class VideoUrl {
  final String url;
  final String name;

  VideoUrl({
    required this.url,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'url': url,
        'name': name,
      };

  factory VideoUrl.fromJson(Map<String, dynamic> json) => VideoUrl(
        url: json['url'],
        name: json['name'],
      );
} 