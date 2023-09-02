import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handlit_flutter/models/base_response.dart';
import 'package:handlit_flutter/models/user_auth_info.dart';
import 'package:handlit_flutter/models/user_card.dart';
import 'package:handlit_flutter/repositories/api/apis.dart';
import 'package:handlit_flutter/repositories/local_pref.dart';

final profileCardNetworkProvider = Provider<ProfileNetwork>((ref) => ProfileNetwork(ref));

class ProfileNetwork {
  final Ref ref;
  const ProfileNetwork(this.ref);

  Future<BaseResponseObject<UserCardsObj>> getMyCards() async {
    // submit eth wallet address to server
    final response = await ref.read(apiProvider).requestGet(
          APIUrl.MY_CARDS,
          (await ref.read(sharedPrefProvider)).getString('x-user-token') ?? '',
        );
    return BaseResponseObject<UserCardsObj>.fromJson(
      response,
      (json) => UserCardsObj.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseResponseObject<UserAuthInfoObj>> getUserInfo() async {
    // submit eth wallet address to server
    return BaseResponseObject<UserAuthInfoObj>.fromJson(
      await ref.read(apiProvider).requestGet(
            APIUrl.WALLET,
            (await ref.read(sharedPrefProvider)).getString('x-user-token') ?? '',
          ),
      (json) => UserAuthInfoObj.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseResponseObject> submitPhoneNumber(String phoneNuber) async {
    // submit phone number to server
    return BaseResponseObject.fromJson(
      await ref.read(apiProvider).requestPost(
            APIUrl.TELEGRAM_SEND_CODE,
            {'phone': phoneNuber},
            (await ref.read(sharedPrefProvider)).getString('x-user-token') ?? '',
          ),
      (json) => json as Map<String, dynamic>,
    );
  }

  Future<BaseResponseObject> submitOTP(String authCode) async {
    final response = await ref.read(apiProvider).requestPost(
          APIUrl.TELEGRAM_SIGN_IN,
          {'code': authCode},
          (await ref.read(sharedPrefProvider)).getString('x-user-token') ?? '',
        );
    // submit OTP to server
    return BaseResponseObject.fromJson(response, (json) => null);
  }

  Future<BaseResponseObject> mintMyCard(Map<String, dynamic> params, List<File> images) async {
    // submit eth wallet address to server
    return BaseResponseObject.fromJson(
      await ref.read(apiProvider).requestPostImages(
            APIUrl.MY_CARDS,
            params,
            images,
            (await ref.read(sharedPrefProvider)).getString('x-user-token') ?? '',
          ),
      (json) => json as Map<String, dynamic>,
    );
  }
}
