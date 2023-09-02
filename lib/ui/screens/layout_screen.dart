import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handlit_flutter/controllers/user_info.dart';
import 'package:handlit_flutter/repositories/scan_qr_repository.dart';
import 'package:handlit_flutter/ui/screens/screens.dart';
import 'package:handlit_flutter/ui/widgets/widgets.dart';
import 'package:styled_widget/styled_widget.dart';

Map<HomeScreenState, Widget> _homeScreenMap = {
  HomeScreenState.home: const HomeScreen(),
  HomeScreenState.myProfile: const MyProfileScreen(),
};

enum HomeScreenState {
  home,
  camera,
  myProfile,
}

final layoutScreenStateProvider = StateProvider((ref) => HomeScreenState.home);

class LayoutScreen extends ConsumerStatefulWidget {
  const LayoutScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends ConsumerState<LayoutScreen> {
  Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userInfoAsyncController.notifier).getUserInfo();
      ref.read(layoutScreenStateProvider.notifier).state = HomeScreenState.home;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          if (index == 1) {
            ref.read(scanQrProvider).showInputBottomSheet(context);
          } else {
            ref.read(layoutScreenStateProvider.notifier).state = HomeScreenState.values[index];
          }
        },
        currentIndex: HomeScreenState.values.indexOf(ref.watch(layoutScreenStateProvider)),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Scan QR'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Library'),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            HandleitCustomHeader(
              leading: Image.asset(
                'assets/images/logo.png',
                height: 28,
                fit: BoxFit.fitHeight,
              ),
              actions: [
                ref.watch(userInfoAsyncController).maybeWhen(data: (userInfoData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: IconButton(
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            backgroundColor: Theme.of(context).colorScheme.background,
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Your address is...', style: Theme.of(context).textTheme.headlineSmall),
                                  const SizedBox(height: 24),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.copy,
                                        size: 18,
                                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        userInfoData?.user?.accessHash ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                              fontSize: 12,
                                              color: Theme.of(context).colorScheme.onSecondaryContainer,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ).gestures(onTap: () {
                              copyToClipboard(userInfoData?.user?.accessHash ?? '');
                              context.pop();
                            }),
                          ),
                        );
                      },
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 18,
                            color: Theme.of(context).colorScheme.onSecondaryContainer,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${(userInfoData?.user?.accessHash ?? '').substring(0, 6)}...',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                }, orElse: () {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: CircularProgressIndicator(),
                  );
                }),
              ],
            ),
            Expanded(
              child: Stack(
                children: _homeScreenMap.entries
                    .map((e) => Offstage(
                          offstage: e.key != ref.watch(layoutScreenStateProvider),
                          child: e.value,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
