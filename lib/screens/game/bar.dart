import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

enum ResourceBarType { health, resource, experience }

class ResourceBar extends StatefulWidget {
  const ResourceBar({
    super.key,
    this.type = ResourceBarType.health,
    this.current = 1,
    this.max = 1,
  });

  final ResourceBarType type;
  final int current;
  final int max;

  @override
  State<ResourceBar> createState() => _ResourceBarState();
}

class _ResourceBarState extends State<ResourceBar> {
  final _logger = Logger();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            getBar(),
            SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Image.asset(
                "assets/ui/bar.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget getBar() {
    _logger.t("getBar");

    var color = "";

    switch (widget.type) {
      case ResourceBarType.health:
        color = "green";
        break;
      case ResourceBarType.resource:
        color = "blue";
        break;
      case ResourceBarType.experience:
        color = "red";
        break;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // _logger.w("Bar: ${widget.current}/${widget.max}");

        return SizedBox(
          width: widget.current == 0
              ? 0
              : MediaQuery.of(context).size.width * widget.current / widget.max,
          height: constraints.maxHeight,
          child: Image.asset(
            "assets/ui/$color.png",
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
