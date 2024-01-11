import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:whistlingwoodz/models/event.dart';

class Party extends Event {
  Timestamp timeStamp;
  Party({
    required String id,
    required String type,
    required String theme,
    required String function,
    required String venue,
    required String guestNo,
    required String budget,
    required String email,
    required String phoneNo,
    required this.timeStamp,
  }) : super(
            id: id,
            type: type,
            theme: theme,
            function: function,
            venue: venue,
            guestNo: guestNo,
            budget: budget,
            email: email,
            phoneNo: phoneNo);

  @override
  toJson() {
    return {
      'id': id,
      'type': 'Party',
      'theme': theme,
      'function': function,
      'venue': venue,
      'guestNo': guestNo,
      'budget': budget,
      'email': email,
      'phoneNo': phoneNo,
      'timeStamp': timeStamp,
    };
  }
}
