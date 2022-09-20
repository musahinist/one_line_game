// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../config/style/palette.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = '/setting';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Palette.backgroundSettings,
        automaticallyImplyLeading: false,
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 32, color: Palette.ink),
        ),
      ),
      backgroundColor: Palette.backgroundSettings,
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // _gap,
          // const Text(
          //   'Settings',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     fontSize: 55,
          //     height: 1,
          //   ),
          // ),
          // //  _gap,
          Text('Player', style: Theme.of(context).textTheme.headline5),
          const Divider(),
          ListTile(
            title: const Text('Name', style: TextStyle(fontSize: 24)),
            trailing: Text('Musa', style: const TextStyle(fontSize: 30)),
          ),
          const SizedBox(height: 24),
          Text('Game', style: Theme.of(context).textTheme.headline5),
          const Divider(),
          ListTile(
            title: const Text('Sound FX', style: TextStyle(fontSize: 24)),
            trailing: Icon(false ? Icons.graphic_eq : Icons.volume_off),
          ),
          ListTile(
            title: const Text('Music', style: TextStyle(fontSize: 24)),
            trailing: Icon(false ? Icons.music_note : Icons.music_off),
          ),
          // Consumer<InAppPurchaseController?>(
          //     builder: (context, inAppPurchase, child) {
          //   if (inAppPurchase == null) {
          //     // In-app purchases are not supported yet.
          //     // Go to lib/main.dart and uncomment the lines that create
          //     // the InAppPurchaseController.
          //     return const SizedBox.shrink();
          //   }

          //   Widget icon;
          //   VoidCallback? callback;
          //   if (inAppPurchase.adRemoval.active) {
          //     icon = const Icon(Icons.check);
          //   } else if (inAppPurchase.adRemoval.pending) {
          //     icon = const CircularProgressIndicator();
          //   } else {
          //     icon = const Icon(Icons.ad_units);
          //     callback = () {
          //       inAppPurchase.buy();
          //     };
          //   }
          //   return _SettingsLine(
          //     'Remove ads',
          //     icon,
          //     onSelected: callback,
          //   );
          // }),
          ListTile(
            title: const Text('Reset progress', style: TextStyle(fontSize: 24)),
            trailing: Icon(Icons.delete),
          ),
          SizedBox(height: 60),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.extended(
          heroTag: "back",
          backgroundColor: Colors.deepOrangeAccent,
          icon: const Icon(Icons.arrow_back),
          shape: StadiumBorder(side: BorderSide(color: Palette.ink, width: 4)),
          label: Text(
            'Back',
            style: TextStyle(fontSize: 24, color: Palette.ink),
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}

// class _NameChangeLine extends StatelessWidget {
//   final String title;

//   const _NameChangeLine(this.title);

//   @override
//   Widget build(BuildContext context) {
//     final settings = context.watch<SettingsController>();

//     return InkResponse(
//       highlightShape: BoxShape.rectangle,
//       onTap: () => showCustomNameDialog(context),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(title,
//                 style: const TextStyle(
//                   fontFamily: 'Permanent Marker',
//                   fontSize: 30,
//                 )),
//             const Spacer(),
//             ValueListenableBuilder(
//               valueListenable: settings.playerName,
//               builder: (context, name, child) => Text(
//                 '‘$name’',
//                 style: const TextStyle(
//                   fontFamily: 'Permanent Marker',
//                   fontSize: 30,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _SettingsLine extends StatelessWidget {
  final String title;

  final Widget icon;

  final VoidCallback? onSelected;

  const _SettingsLine(this.title, this.icon, {this.onSelected});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: onSelected,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: const TextStyle(
                  fontFamily: 'Permanent Marker',
                  fontSize: 30,
                )),
            const Spacer(),
            icon,
          ],
        ),
      ),
    );
  }
}
