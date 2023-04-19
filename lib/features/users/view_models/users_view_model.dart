import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repository.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _usersRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _usersRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      final profile = await _usersRepository
          .findProfile(_authenticationRepository.user!.uid);

      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }

    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null) throw Exception("Account not created");

    final signUpInfo = ref.read(signUpForm);

    credential.user!.updateDisplayName(signUpInfo['name']);

    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      bio: signUpInfo['bio'] ?? "undefined",
      link: "undefined",
      email: credential.user!.email ?? "anon@anon.com",
      uid: credential.user!.uid,
      name: signUpInfo['name'] ?? "Anon",
    );

    await _usersRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
