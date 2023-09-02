import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handlit_flutter/models/exchanged_card.dart';
import 'package:handlit_flutter/repositories/api/exception/exception_wrapper.dart';
import 'package:handlit_flutter/repositories/network/exchanged_card_network.dart';

final exchangedCardAsyncController = StateNotifierProvider<ExchangedCardAsyncNotifier, AsyncValue<ExchangedCardListObj?>>((ref) => ExchangedCardAsyncNotifier(ref));

class ExchangedCardAsyncNotifier extends StateNotifier<AsyncValue<ExchangedCardListObj?>> {
  ExchangedCardAsyncNotifier(this.ref) : super(const AsyncValue.data(null));

  final StateNotifierProviderRef<ExchangedCardAsyncNotifier, AsyncValue<ExchangedCardListObj?>> ref;

  Future<void> getExchangedCards() async {
    state = const AsyncValue.loading();
    final responseObj = await ref.read(exchangedCardNetworkProvider).getExchangedCards();
    if (responseObj.error) {
      state = AsyncValue.error(CustomException(code: responseObj.errors?[0].code ?? '', message: responseObj.errorName, substring: responseObj.errors![0].message.toString()),
          StackTrace.fromString(responseObj.errors.toString()));
    } else {
      state = AsyncValue.data(responseObj.value);
    }
  }
}
