import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CommonScaffoldView extends HookWidget {
  final Widget body;
  final String title;
  final List<Widget> actions;
  final bool showLanding;

  const CommonScaffoldView({
    required this.title,
    required this.body,
    this.actions = const <Widget>[],
    this.showLanding = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnimationController controller =
        useAnimationController(duration: const Duration(seconds: 0));

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: SizedBox(),
      ),
      body: NotificationListener(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.axis == Axis.vertical &&
              scrollInfo.metrics.pixels <= 10) {
            controller.animateTo(scrollInfo.metrics.pixels / 10);
            return true;
          } else {
            controller.animateTo(1.0);
            return false;
          }
        },
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight),
                child: body,
              ),
              SizedBox(
                height: kToolbarHeight,
                width: MediaQuery.of(context).size.width,
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) => PhysicalModel(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    elevation:
                        Tween(begin: 0.0, end: 4.0).animate(controller).value,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(Tween(begin: 0.0, end: 18.0)
                            .animate(controller)
                            .value),
                        bottomRight: Radius.circular(
                            Tween(begin: 0.0, end: 18.0)
                                .animate(controller)
                                .value)),
                    child: child,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: showLanding
                            ? InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                customBorder: const CircleBorder(),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.arrow_back),
                                ),
                              )
                            : const SizedBox(width: 40),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: actions.isEmpty
                            ? [
                                const Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: SizedBox(width: 40),
                                )
                              ]
                            : actions,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
