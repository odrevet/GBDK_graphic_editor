import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_boy_graphics_editor/cubits/app_state_cubit.dart';
import 'package:game_boy_graphics_editor/cubits/meta_tile_cubit.dart';
import 'package:game_boy_graphics_editor/models/graphics/meta_tile.dart';
import 'package:game_boy_graphics_editor/widgets/background/background_editor.dart';
import 'package:game_boy_graphics_editor/widgets/tiles/tiles_editor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_state.dart';
import 'menu_bar.dart';

Future<void> _initPreferences(BuildContext context) async {
  SharedPreferences.getInstance().then((prefs) {
    String? storedString = prefs.getString('gbdkPath');
    if (storedString != null) {
      context.read<AppStateCubit>().setGbdkPath(storedString);
      context.read<AppStateCubit>().setGbdkPathValid();
    }
  });
}

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _initPreferences(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppStateCubit, AppState>(
      builder: (context, appState) => BlocBuilder<MetaTileCubit, MetaTile>(
        builder: (context, metaTile) {
          dynamic editor = appState.tileMode
              ? const TilesEditor()
              : BackgroundEditor(
                  tiles: metaTile,
                  onTapTileListView: (index) => context
                      .read<AppStateCubit>()
                      .setTileIndexBackground(index),
                  showGrid: appState.showGridBackground,
                );

          return Scaffold(
              body: SafeArea(
            child: Column(
              children: [ApplicationMenuBar(), Expanded(child: editor)],
            ),
          ));
        },
      ),
    );
  }
}
