import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handlit_flutter/models/user_auth_info.dart';
import 'package:handlit_flutter/repositories/api/exception/exception_wrapper.dart';
import 'package:handlit_flutter/repositories/network/auth_network.dart';

final userInfoAsyncController = StateNotifierProvider<UserInfoAsyncNotifier, AsyncValue<UserAuthInfoObj?>>((ref) => UserInfoAsyncNotifier(ref));

class UserInfoAsyncNotifier extends StateNotifier<AsyncValue<UserAuthInfoObj?>> {
  UserInfoAsyncNotifier(this.ref) : super(const AsyncValue.data(null));

  final StateNotifierProviderRef<UserInfoAsyncNotifier, AsyncValue<UserAuthInfoObj?>> ref;

  Future<void> getUserInfo() async {
    state = const AsyncValue.loading();
    final responseObj = await ref.read(authNetworkProvider).getUserInfo();
    if (responseObj.error) {
      state = AsyncValue.error(CustomException(code: responseObj.errors?[0].code ?? '', message: responseObj.errorName, substring: responseObj.errors![0].message.toString()),
          StackTrace.fromString(responseObj.errors.toString()));
    } else {
      state = AsyncValue.data(responseObj.value);
    }
  }
}
