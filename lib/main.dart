import 'package:flutter/material.dart';

void main() {
  runApp(const CookieClickerApp());
}

class CookieClickerApp extends StatelessWidget {
  const CookieClickerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cookie clicker!',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const CookieClickerHomePage(title: '🍪 Cookie clicker 🍪'),
    );
  }
}

class CookieClickerHomePage extends StatefulWidget {
  const CookieClickerHomePage({super.key, required this.title});
  final String title;

  @override
  State<CookieClickerHomePage> createState() => _CookieClickerHomePageState();
}

class _CookieClickerHomePageState extends State<CookieClickerHomePage> {
  int _counter = 0;
  String _cookieText = 'Click the cookie!';
  Color _arrowColor = const Color(0xff999999);
  final _winPoints = 200;
  final _pointsOnClick = 10;
  final _initialSize = 120.0;
  final _scaling = 1;
  double _width = 500, _height = 300;

  void _showWinDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Wygrana!'),
        content: const Text('Gratulacje!'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Dalej'),
            child: const Text('Dalej'),
          ),
        ],
      ),
    );
  }

  void _incrementCounter(BuildContext context) {
    setState(() {
      _counter += _pointsOnClick;
      _width += 20;
      _height += 20;
      _counter %= (_winPoints + _pointsOnClick);
      if (_counter == 0) {
        _arrowColor = const Color(0xff555555);
        _width = 500;
        _height = 300;
        _cookieText = 'Click the cookie!';
      } else if (_counter >= _winPoints) {
        // ignore: avoid_print
        print('here');
        _showWinDialog(context);
        _cookieText = 'You won!';
      } else {
        _arrowColor = const Color(0x00000000);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _cookieText,
            ),
            Text(
              'Score: $_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Icon(Icons.arrow_downward_rounded, color: _arrowColor, size: 75),
            Container(
              alignment: Alignment.center,
              width: 500,
              height: 300,
              child: AnimatedContainer(
                alignment: Alignment.center,
                width: _initialSize + _counter * _scaling,
                height: _initialSize + _counter * _scaling,
                // transform: Matrix4.rotationZ(0.001 * _counter),
                duration: const Duration(milliseconds: 500),
                curve: Curves.bounceOut,
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 18.0),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: .5, color: const Color(0xFF010101)),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(color: Colors.black, blurRadius: 5.0)
                          ],
                          color: const Color(0xFF010101),
                          image: const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/cookie.png'),
                          )),
                    ),
                  ),
                  onTap: () {
                    _incrementCounter(context);
                  },
                  onLongPressStart: (_) async {},
                  onLongPressCancel: () {},
                  onLongPressEnd: (_) {
                    setState(() {
                      _counter = 0;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
