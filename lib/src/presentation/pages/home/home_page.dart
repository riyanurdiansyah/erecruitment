import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recruitment/src/presentation/pages/widgets/header.dart';

import '../../../../utils/app_color.dart';
import '../../blocs/home/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeBloc = HomeBloc();

  @override
  void initState() {
    _homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => _homeBloc,
      child: Scaffold(
        backgroundColor: backgroundGrey,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 35),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(
                  height: 25,
                ),
                Header(),
                SizedBox(
                  height: 25,
                ),
                // WebRekapHomeCard(),
                // BlocBuilder<HomeBloc, HomeState>(
                //   builder: (context, state) {
                //     if (state.isShowHadirToday == true) {
                //       return Container(
                //         height: 200,
                //         width: 300,
                //         color: Colors.red,
                //       );
                //     }
                //     return const SizedBox();
                //   },
                // ),
                // const SizedBox(
                //   height: 25,
                // ),
                // const WebLastActivityHomeCard(),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
