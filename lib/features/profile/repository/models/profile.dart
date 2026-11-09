class Profile {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final String phoneNumber;
  final String location;
  final String bio;
  final int booking;
  final int favorite;
  final int notification;

  new({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.phoneNumber,
    required this.location,
    required this.bio,
    required this.booking,
    required this.favorite,
    required this.notification,
  });
}
