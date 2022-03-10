import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/ui/view/single_progress_screen/single_progress_screen.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ProjectProgressTimeLineScreen extends StatelessWidget {
  const ProjectProgressTimeLineScreen({Key? key}) : super(key: key);
  static const routeName = '/projectProgressTimeLineScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
        child: const CustomAppBar(
          automaticallyImplyLeading: true,

          bannerText: "Progress Timeline",
          showBothIcon: false,
        ),
      ),
      body: ListView.builder(
        itemCount: examples.length,
        itemBuilder: (BuildContext context, int index) {
          final example = examples[index];

          return TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.08,
            isFirst: index == 0,
            isLast: index == examples.length - 1,
            indicatorStyle: IndicatorStyle(
              width: 40,
              height: 40,
              indicator: _IndicatorExample(number: '${index + 1}'),
              drawGap: false,
            ),
            beforeLineStyle:
                const LineStyle(thickness: 3, color: AppColors.mainThemeBlue),
            endChild: GestureDetector(
              child: _RowExample(example: example),
              onTap: () {
                Navigator.of(context).pushNamed(SingleProgressScreen.routeName);
              },
            ),
          );
        },
      ),
    );
  }
}

class _IndicatorExample extends StatelessWidget {
  const _IndicatorExample({Key? key, required this.number}) : super(key: key);

  final String number;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.mainThemeBlue,
      child: Text(
        number,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
      ),
    );
  }
}

class _RowExample extends StatelessWidget {
  const _RowExample({Key? key, required this.example}) : super(key: key);

  final Example example;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 11.h,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("December 22,2021",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: AppColors.greyDark)),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        example.name,
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: AppColors.mainThemeBlue),
                      ),
                    ),
                    const ColoredLabel(
                        color: AppColors.mainThemeBlue, text: "5 Notes"),
                  ],
                ),
                Text(
                  AppConstant.dummy,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: AppColors.greyDark),
                  maxLines: 1,
                )
              ],
            ),
          ),
          const Icon(
            Icons.navigate_next,
            color: AppColors.mainThemeBlue,
            size: 26,
          ),
        ],
      ),
    );
  }
}

class Example {
  const Example({
    required this.name,
    required this.description,
    required this.code,
    required this.childHorizontal,
    required this.childVertical,
  });

  final String name;
  final String description;
  final String code;
  final Widget childVertical;
  final Widget childHorizontal;
}

const examples = <Example>[
  example1,
  example1,
  example1,
  example1,
  example1,
  example1,
  example1,
  example1,
  example1,
  example1,
  example1,
  example1,
  example1,
  example1,
  example1,
  example1,
  example1,
  example1,
  example1,
  example1,
];
const example1 = Example(
  name: 'The simplest tile',
  description: 'If the axis is vertical, it aligns default to the start, with '
      'a height of 100. The tile will always try to be as wide as it can get horizontally.\n\n'
      'If the axis is horizontal, It aligns default to the start, with a width'
      'of 100. The tile will always try to be as wide as it can get vertically.',
  code: '''
/// Vertical
return Container(
  color: Colors.white,
  child: TimelineTile(),
);
/// Horizontal
return Container(
  color: Colors.white,
  child: TimelineTile(
    axis: TimelineAxis.horizontal,
  ),
);''',
  childVertical: Example1Vertical(),
  childHorizontal: Example1Horizontal(),
);

class Example1Vertical extends StatelessWidget {
  const Example1Vertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Container(
            color: Colors.white,
            child: TimelineTile(),
          ),
        ],
      ),
    );
  }
}

class Example1Horizontal extends StatelessWidget {
  const Example1Horizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Row(
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 100),
                color: Colors.white,
                child: TimelineTile(
                  axis: TimelineAxis.horizontal,
                  alignment: TimelineAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
