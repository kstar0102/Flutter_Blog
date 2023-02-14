import 'package:flutter/material.dart';

class ConnectionLostWidget extends StatefulWidget {
  const ConnectionLostWidget({Key? key}) : super(key: key);

  @override
  State<ConnectionLostWidget> createState() => _ConnectionLostWidgetState();
}

class _ConnectionLostWidgetState extends State<ConnectionLostWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width * 0.8,
          height: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const Icon(Icons.signal_wifi_off),
              const SizedBox(
                height: 10,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Waiting for wifi   ',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    WidgetSpan(
                      baseline: TextBaseline.alphabetic,
                      alignment: PlaceholderAlignment.baseline,
                      child: SizedBox(
                        width: Theme.of(context).textTheme.bodyText1!.fontSize! - 4,
                        height: Theme.of(context).textTheme.bodyText1!.fontSize! - 4,
                        child: const CircularProgressIndicator(
                          strokeWidth: 1.4,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
