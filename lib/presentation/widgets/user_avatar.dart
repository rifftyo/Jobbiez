import 'package:flutter/material.dart';
import 'package:jobbiez/common/constants.dart';
import 'package:jobbiez/common/state_enum.dart';

class UserAvatar extends StatelessWidget {
  final String? username;
  final String? fotoProfile;
  final double radius;
  final RequestState state;

  const UserAvatar({
    super.key,
    required this.username,
    required this.fotoProfile,
    required this.radius,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final initial =
        (username != null && username!.isNotEmpty)
            ? username![0].toUpperCase()
            : '';

    if (state == RequestState.Loading) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey[200],
      );
    }

    if (fotoProfile != null && fotoProfile!.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey[200],
        backgroundImage: NetworkImage(fotoProfile!),
      );
    } else {
      return CircleAvatar(
        radius: radius,
        backgroundColor: kYellow,
        child: Text(initial, style: kManropeHeading1),
      );
    }
  }
}
