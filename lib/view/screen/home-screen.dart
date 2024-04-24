import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';
import 'package:rolling_switch/rolling_switch.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.serverConfig});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  final List<String> serverConfig;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'RahaVpn',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: const [
          Icon(Icons.settings, size: 35),
          SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: v2rayStatus,
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                RollingSwitch.icon(
                  width: 180,
                  height: 60,
                  onChanged: (bool state) {
                    if (isConnect) {
                      flutterV2ray.stopV2Ray();
                    } else {
                      onConnect();
                    }
                  },
                  rollingInfoRight: RollingIconInfo(
                    text: Text(value.state),
                  ),
                  rollingInfoLeft: RollingIconInfo(
                    backgroundColor: Colors.grey,
                    text: Text(value.state),
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
                _buildBottomAppbar(widget.serverConfig),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomAppbar(List<String> serversConfig) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.5,
            maxChildSize: 0.7,
            builder: (context, scrollController) => Container(
              decoration: const BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: ListView.builder(
                controller: scrollController,
                cacheExtent: 20,
                itemCount: serversConfig.length,
                itemBuilder: (context, index) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(serversConfig[index].toString()),
                        const Icon(Icons.settings_input_antenna),
                      ],
                    ),
                  ),
                ),
              ),
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
