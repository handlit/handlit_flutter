import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handlit_flutter/models/base_response.dart';
import 'package:handlit_flutter/models/exchanged_card.dart';
import 'package:handlit_flutter/repositories/api/apis.dart';
import 'package:handlit_flutter/repositories/local_pref.dart';

final exchangedCardNetworkProvider = Provider<ExchangedCardNetwork>((ref) => ExchangedCardNetwork(ref));

class ExchangedCardNetwork {
  final Ref ref;
  const ExchangedCardNetwork(this.ref);

  Future<BaseResponseObject<ExchangedCardListObj>> getExchangedCards() async {
    // submit eth wallet address to server
    final response = await ref.read(apiProvider).requestGet(
          APIUrl.MY_CARDS,
          (await ref.read(sharedPrefProvider)).getString('x-user-token') ?? '',
        );
    return BaseResponseObject<ExchangedCardListObj>.fromJson(
      response,
      (json) => ExchangedCardListObj.fromJson(json as Map<String, dynamic>),
    );
  }
}
