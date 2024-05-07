import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';
import 'package:v2ray/core/class/model/MyPrefrences.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../core/function/get-imei.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.serverConfig});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  final List<String> serverConfig;
}

class _HomeScreenState extends State<HomeScreen> {
  late final FlutterV2ray flutterV2ray = FlutterV2ray(
    onStatusChanged: (status) {
      v2rayStatus.value = status;
    },
  );

  var v2rayStatus = ValueNotifier<V2RayStatus>(V2RayStatus());
  String link = '';

  void onConnect() async {
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

  final List<Map<String, String>> _countryNames = [
    {'am': 'ارمنستان'},
    {'aw': 'آروبا'},
    {'au': 'استرالیا'},
    {'at': 'اتریش'},
    {'az': 'جمهوری آذربایجان'},
    {'bs': 'باهاما'},
    {'bh': 'بحرین'},
    {'bd': 'بنگلادش'},
    {'bb': 'باربادوس'},
    {'by': 'بلاروس'},
    {'be': 'بلژیک'},
    {'bz': 'بلیز'},
    {'bj': 'بنین'},
    {'bm': 'برمودا'},
    {'bt': 'بوتان'},
    {'bo': 'بولیوی'},
    {'bq': 'بونیر، سنت اوستاتیوس و سبا'},
    {'ba': 'بوسنی و هرزگوین'},
    {'bw': 'بوتسوانا'},
    {'bv': 'جزیره بووه'},
    {'am': 'ارمنستان'},
    {'aw': 'آروبا'},
    {'au': 'استرالیا'},
    {'at': 'اتریش'},
    {'az': 'جمهوری آذربایجان'},
    {'bs': 'باهاما'},
    {'bh': 'بحرین'},
    {'bd': 'بنگلادش'},
    {'bb': 'باربادوس'},
  ];
  String selectedServerConfig = '';

  @override
  void initState() {
    super.initState();
    checkUserAccess();
    flutterV2ray.initializeV2Ray().then((value) async {
      // initial server address
      link = widget.serverConfig[0].trim();
      selectedServerConfig = _countryNames[0].keys.first;
      setState(() {});
    });
  }

  Future<void> checkUserAccess() async {
    String phoneNumber = await MyPreferences.readPhoneNumberUser();
    String macAddress = await ImeiManager().getDeviceIMEINumber();
    if (phoneNumber.isNotEmpty && widget.serverConfig.isEmpty) {
      // start Event
      BlocProvider.of<AuthBloc>(context).add(
        AuthLoginEvent(
          phoneNumber: phoneNumber,
          macAddress: macAddress,
        ),
      ); // end of Event
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: v2rayStatus,
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                const Wrap(
                  spacing: 2,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.vertical,
                  children: [
                    Text(
                      'Welcome to',
                      style: TextStyle(fontSize: 26),
                    ),
                    Text(
                      'Raha VPn',
                      style: TextStyle(color: Color(0xff396AFC), fontSize: 24),
                    ),
                  ],
                ),
                const SizedBox(height: 42),
                _buildChooseSeverConfig(),
                const SizedBox(height: 42),
                GestureDetector(
                  onTap: () {
                    if (value.state == 'CONNECTED') {
                      flutterV2ray.stopV2Ray();
                    } else {
                      onConnect();
                    }
                    setState(() {});
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff3D83FF),
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(75)),
                    child: Center(
                        child: value.state == 'CONNECTED'
                            ? Image.asset('images/tap-disconnect.png')
                            : Image.asset('images/tap-connect.png')),
                  ),
                ),
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Status : ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        )),
                    Text(
                      ' ${v2rayStatus.value.state} ',
                      style: TextStyle(
                        color: v2rayStatus.value.state == 'CONNECTED'
                            ? Colors.green
                            : Colors.red,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
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
                // const Spacer(),
                // _buildChooseSeverConfig(widget.serverConfig),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildChooseSeverConfig() {
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
              child: Column(
                children: [
                  if (widget.serverConfig.isEmpty) ...{
                    const Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: 35),
                      child: Text('سروری وجود ندارد',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          )),
                    )),
                  },
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      cacheExtent: 20,
                      itemCount: widget.serverConfig.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          height: 80,
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: InkWell(
                              onTap: () {
                                link = widget.serverConfig[index].trim();
                                selectedServerConfig =
                                    _countryNames[index].keys.first;
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CountryFlag.fromCountryCode(
                                    _countryNames[index].keys.first,
                                    height: 48,
                                    width: 62,
                                    borderRadius: 5,
                                  ),
                                  Text(
                                    _countryNames[index].values.first,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color(0xff1D2031),
          borderRadius: BorderRadius.circular(34),
          border: Border.all(
            color: const Color(0xff3D83FF),
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CountryFlag.fromCountryCode(
                selectedServerConfig,
                height: 48,
                width: 62,
                borderRadius: 5,
              ),
              const SizedBox(width: 10),
              const Icon(CupertinoIcons.right_chevron),
            ],
          ),
        ),
      ),
    );
  }
}
