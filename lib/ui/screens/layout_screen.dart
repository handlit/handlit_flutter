import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handlit_flutter/repositories/scan_qr_repository.dart';
import 'package:handlit_flutter/ui/screens/screens.dart';
import 'package:handlit_flutter/ui/widgets/widgets.dart';

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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: IconButton(
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      context.push('/settings');
                    },
                    icon: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 18,
                          color: Theme.of(context).colorScheme.onSecondaryContainer,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '0xb12F...',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.onSecondaryContainer,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
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
