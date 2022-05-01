import 'package:flutter/material.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';

Widget profileSelector(List<ProfileDocument> profiles, ProfileDocument currentProfile, Function(ProfileDocument profile) onChange) {
  return StatefulBuilder(builder: (BuildContext context, StateSetter dropDownState) {
    return DropdownButton(
      value: currentProfile,
      items: List.generate(
        profiles.length,
        (index) => DropdownMenuItem(
          child: Text(
              "${profiles[index].name} ${profiles[index].service.hasValue ? ' - ' + profiles[index].service.target!.serviceName : ''}"),
          value: profiles[index],
        ),
      ),
      onChanged: (ProfileDocument? profile) {
        dropDownState(() {
          if (profile != null) {
            currentProfile = profile;
            onChange(currentProfile);
          }
        });
      },
    );
  });
}
