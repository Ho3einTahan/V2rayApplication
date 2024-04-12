import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isConnect = false;
  late final FlutterV2ray flutterV2ray = FlutterV2ray(
    onStatusChanged: (status) {
      v2rayStatus.value = status;
      if (status.state == 'CONNECTED') {
        isConnect = true;
      } else {
        isConnect = false;
      }
    },
  );

  var v2rayStatus = ValueNotifier<V2RayStatus>(V2RayStatus());

  void onConnect() async {
    String link =
        "vless://6f2f97ad-671b-4aea-9193-41def8d971f5@ghavidel.mandegar.top:19160?mode=gun&security=tls&encryption=none&authority=&type=grpc&serviceName=&sni=fast.com#IRANCELL8";
    V2RayURL parser = FlutterV2ray.parseFromURL(link);

    if (await flutterV2ray.requestPermission()) {
      flutterV2ray.startV2Ray(
        remark: parser.remark,
        config: parser.getFullConfiguration(),
        proxyOnly: false,
        bypassSubnets: [],
      );
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Permission Denied'),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    flutterV2ray.initializeV2Ray().then((value) async {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: v2rayStatus,
      builder: (context, value, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 120, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Spacer(),
                  const Text(
                    'RahaVpn',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 4 - 10),
                  const Icon(Icons.settings, size: 35),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (isConnect) {
                  flutterV2ray.stopV2Ray();
                } else {
                  onConnect();
                }
              },
              child: AvatarGlow(
                child: Material(
                  elevation: 2.0,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor:
                        isConnect ? Colors.green[500] : Colors.red[700],
                    radius: 70.0,
                    child: Text(value.state),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 75),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Time : '),
                const SizedBox(width: 10), // Adding vertical space
                Text(value.duration),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Speed:'),
                const SizedBox(width: 10),
                Text(value.uploadSpeed),
                const Text('↑'),
                const SizedBox(width: 10),
                Text(value.downloadSpeed),
                const Text('↓'),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Traffic:'),
                const SizedBox(width: 10),
                Text(value.upload),
                const Text('↑'),
                const SizedBox(width: 10),
                Text(value.download),
                const Text('↓'),
              ],
            ),
            const Spacer(),
            _buildBottomAppbar(),
          ],
        );
      },
    );
  }

  Widget _buildBottomAppbar() {
    return InkWell(
      onTap: () {
        showBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.5,
            maxChildSize: 1,
            builder: (context, scrollController) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Text('d'),
            ),
          ),
        );
      },
      child: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Choose Server Address'),
            SizedBox(width: 10),
            Icon(CupertinoIcons.up_arrow),
          ],
        ),
      ),
    );
  }
}
