import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handlit_flutter/ui/widgets/auth_number_pad.dart';
import 'package:handlit_flutter/ui/widgets/buttons.dart';
import 'package:handlit_flutter/ui/widgets/headers.dart';
import 'package:handlit_flutter/utils/routes.dart';

final authCodeStateProvider = StateProvider<List<int>>((ref) => []);

class TelegramAuthCodeInputScreen extends ConsumerStatefulWidget {
  const TelegramAuthCodeInputScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TelegramAuthCodeInputScreenState();
}

class _TelegramAuthCodeInputScreenState extends ConsumerState<TelegramAuthCodeInputScreen> {
  late TextEditingController _countryEditingController;
  late TextEditingController _phoneEditingController;
  late FocusNode _countryFocusNode;
  late FocusNode _phoneFocusNode;

  @override
  void initState() {
    super.initState();
    _countryEditingController = TextEditingController();
    _phoneEditingController = TextEditingController();
    _countryFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    Future(
      () {},
    );
  }

  @override
  void dispose() {
    super.dispose();
    _countryEditingController.dispose();
    _phoneEditingController.dispose();
    _countryFocusNode.dispose();
    _phoneFocusNode.dispose();
  }

  Future<void> _authVerificationCode() async {
    // TODO: Send verification code
    context.go('/${HandleItRoutes.layout.name}');
    context.push('/${HandleItRoutes.verified.name}');
    ref.read(authCodeStateProvider.notifier).state = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HandleitCustomHeader(
              title: 'Telegram verification',
              leading: CustomBackButton(),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Text('Enter code', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 24),
                    AutoSizeText(
                      //TODO : Change to real phone number
                      'We’ve sent an SMS with an activation code\nto your phone +82 1051443347',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...ref.watch(authCodeStateProvider).map((e) {
                            return NumberPadItem(number: e);
                          }).toList(),
                          ...List.generate(5 - ref.watch(authCodeStateProvider).length, (index) => const NumberPadItem(number: null)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Didn’t get the code?',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                    const Spacer(),
                    NumPad(
                      onTap: (int value) {
                        if (value == 99 && ref.read(authCodeStateProvider).isNotEmpty) {
                          ref.read(authCodeStateProvider.notifier).state = [...ref.read(authCodeStateProvider).sublist(0, ref.read(authCodeStateProvider).length - 1)];
                          return;
                        } else if (value == 99 && ref.read(authCodeStateProvider).isEmpty) {
                          return;
                        }
                        ref.read(authCodeStateProvider.notifier).state = [...ref.read(authCodeStateProvider), value];
                        if (ref.read(authCodeStateProvider).length == 5) {
                          _authVerificationCode();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberPadItem extends ConsumerWidget {
  const NumberPadItem({super.key, this.number});
  final int? number;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: number == null ? Theme.of(context).colorScheme.primary.withOpacity(0.05) : Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          '${number ?? ''}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 24,
              ),
        ),
      ),
    );
  }
}
