import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handlit_flutter/models/user_card.dart';
import 'package:handlit_flutter/repositories/api/exception/exception_wrapper.dart';
import 'package:handlit_flutter/repositories/network/profile_card_network.dart';

final userCardListAsyncController = StateNotifierProvider<UserCardListAsyncNotifier, AsyncValue<UserCardsObj?>>((ref) => UserCardListAsyncNotifier(ref));

class UserCardListAsyncNotifier extends StateNotifier<AsyncValue<UserCardsObj?>> {
  UserCardListAsyncNotifier(this.ref) : super(const AsyncValue.data(null));

  final StateNotifierProviderRef<UserCardListAsyncNotifier, AsyncValue<UserCardsObj?>> ref;

  Future<void> getUserCardList() async {
    state = const AsyncValue.loading();
    final responseObj = await ref.read(profileCardNetworkProvider).getMyCards();
    if (responseObj.error) {
      state = AsyncValue.error(CustomException(code: responseObj.errors?[0].code ?? '', message: responseObj.errorName, substring: responseObj.errors![0].message.toString()),
          StackTrace.fromString(responseObj.errors.toString()));
    } else {
      state = AsyncValue.data(responseObj.value);
    }
  }

  Future<void> mintUserCard(Map<String, dynamic> params, List<File> images) async {
    state = const AsyncValue.loading();
    final responseObj = await ref.read(profileCardNetworkProvider).mintMyCard(params, images);
    if (responseObj.error) {
      state = AsyncValue.error(CustomException(code: responseObj.errors?[0].code ?? '', message: responseObj.errorName, substring: responseObj.errors![0].message.toString()),
          StackTrace.fromString(responseObj.errors.toString()));
    } else {
      await getUserCardList();
    }
  }
}
