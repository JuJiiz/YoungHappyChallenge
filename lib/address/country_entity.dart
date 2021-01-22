class CountryEntity {
  int id;
  String name;
  String nativeName;
  String alpha3Code;
  String nationality;
  String imageUrl;

  CountryEntity({
    this.id,
    this.name,
    this.nativeName,
    this.alpha3Code,
    this.nationality,
    this.imageUrl,
  });

  factory CountryEntity.fromJson(Map<String, dynamic> json) => CountryEntity(
        id: json["id"],
        name: json["name"],
        nativeName: json["native_name"],
        alpha3Code: json["alpha3_code"],
        nationality: json["nationality"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "native_name": nativeName,
        "alpha3_code": alpha3Code,
        "nationality": nationality,
        "image_url": imageUrl,
      };
}
