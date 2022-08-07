class Address {
  final String id;
  final String? primary;
  final String? secondary;
  final String? city;
  final String? state;
  final String? zip;
  final String? country;
  final String? latitude;
  final String? longitude;
  final String? relatedId;
  final String? relatedType;

  const Address({
    required this.id,
    this.primary,
    this.secondary,
    this.city,
    this.state,
    this.zip,
    this.country,
    this.latitude,
    this.longitude,
    this.relatedId,
    this.relatedType,
  });
}
