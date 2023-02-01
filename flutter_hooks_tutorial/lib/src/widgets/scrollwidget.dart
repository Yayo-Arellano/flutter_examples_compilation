import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final _red = new GlobalKey();
final _blue = new GlobalKey();
final _yellow = new GlobalKey();
final _green = new GlobalKey();
final _orange = new GlobalKey();

class ScrollWidget extends HookWidget {
  void scrollTo(GlobalKey key) => Scrollable.ensureVisible(key.currentContext!, duration: Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    final _controller = useScrollController();

    // How to set a listener: https://stackoverflow.com/a/63832263/3479489
    useEffect(() {
      print('This will be called only one time');
      _controller.addListener(() => print('Scroll Position: ${_controller.position.pixels}'));
      return _controller.dispose;
    }, [_controller]);

    final containerHeight = MediaQuery.of(context).size.height * .80; // 80% of the height

    return Scaffold(
      appBar: AppBar(
        title: Text('Create account'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                onPressed: () => scrollTo(_red),
                child: Text('Red'),
              ),
              OutlinedButton(
                onPressed: () => scrollTo(_blue),
                child: Text('Blue'),
              ),
              OutlinedButton(
                onPressed: () => scrollTo(_yellow),
                child: Text('Yellow'),
              ),
              OutlinedButton(
                onPressed: () => scrollTo(_green),
                child: Text('Green'),
              ),
              OutlinedButton(
                onPressed: () => scrollTo(_orange),
                child: Text('Orange'),
              )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: [
                  Container(
                    key: _red,
                    height: containerHeight,
                    color: Colors.red,
                  ),
                  Container(
                    key: _blue,
                    height: containerHeight,
                    color: Colors.blue,
                  ),
                  Container(
                    key: _yellow,
                    height: containerHeight,
                    color: Colors.yellow,
                  ),
                  Container(
                    key: _green,
                    height: containerHeight,
                    color: Colors.green,
                  ),
                  Container(
                    key: _orange,
                    height: containerHeight,
                    color: Colors.orange,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
