import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_boy_graphics_editor/cubits/background_cubit.dart';
import 'package:game_boy_graphics_editor/cubits/meta_tile_cubit.dart';
import 'package:game_boy_graphics_editor/models/graphics/background.dart';
import 'package:game_boy_graphics_editor/models/sourceConverters/gbdk_background_converter.dart';
import 'package:game_boy_graphics_editor/widgets/background/background_grid.dart';
import 'package:game_boy_graphics_editor/widgets/tiles/meta_tile_display.dart';
import 'package:game_boy_graphics_editor/widgets/tiles/meta_tile_list_view.dart';

import '../../cubits/app_state_cubit.dart';
import '../../models/graphics/meta_tile.dart';
import '../source_display.dart';

class BackgroundEditor extends StatefulWidget {
  final MetaTile tiles;
  final Function? onTapTileListView;
  final bool showGrid;

  const BackgroundEditor(
      {super.key,
      required this.tiles,
      this.onTapTileListView,
      this.showGrid = false});

  @override
  State<BackgroundEditor> createState() => _BackgroundEditorState();
}

class _BackgroundEditorState extends State<BackgroundEditor> {
  int hoverTileIndexX = 0;
  int hoverTileIndexY = 0;

  @override
  Widget build(BuildContext context) {
    int hoverTileIndex =
        hoverTileIndexY * context.read<BackgroundCubit>().state.width +
            hoverTileIndexX;
    return BlocBuilder<BackgroundCubit, Background>(
        builder: (context, background) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: MetaTileListView(
                  selectedTile:
                      context.read<AppStateCubit>().state.tileIndexBackground,
                  onTap: (index) => widget.onTapTileListView != null
                      ? widget.onTapTileListView!(index)
                      : null),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ContextMenuArea(
                  builder: (contextMenuArea) => [
                    /*ListTile(
                      title: const Text('Insert column before'),
                      onTap: () {
                        context.read<BackgroundCubit>().insertCol(
                            hoverTileIndex,
                            context
                                .read<AppStateCubit>()
                                .state
                                .tileIndexBackground);
                        Navigator.of(contextMenuArea).pop();
                      },
                    ),
                    ListTile(
                      title: const Text('Delete column'),
                      onTap: () {
                        context
                            .read<BackgroundCubit>()
                            .deleteCol(hoverTileIndex);
                        Navigator.of(contextMenuArea).pop();
                      },
                    ),
                    ListTile(
                      title: const Text('Insert row before'),
                      onTap: () {
                        context.read<BackgroundCubit>().insertRow(
                            hoverTileIndex,
                            context
                                .read<AppStateCubit>()
                                .state
                                .tileIndexBackground);
                        Navigator.of(contextMenuArea).pop();
                      },
                    ),
                    ListTile(
                      title: const Text('Remove row'),
                      onTap: () {
                        context.read<BackgroundCubit>().insertRow(
                            hoverTileIndex,
                            context
                                .read<AppStateCubit>()
                                .state
                                .tileIndexBackground);
                        Navigator.of(contextMenuArea).pop();
                      },
                    )*/
                  ],
                  child: Column(
                    children: [
                      Expanded(
                        child: BackgroundGrid(
                          background: context.read<BackgroundCubit>().state,
                          showGrid: widget.showGrid,
                          metaTile: widget.tiles,
                          cellSize: 40 * context.read<AppStateCubit>().state.zoomBackground,
                          onTap: (index) => context
                              .read<BackgroundCubit>()
                              .setTileIndex(
                                  index % background.width,
                                  index ~/ background.width,
                                  context
                                      .read<AppStateCubit>()
                                      .state
                                      .tileIndexBackground),
                          onHover: (x, y) => setState(() {
                            hoverTileIndexX = x;
                            hoverTileIndexY = y;
                          }),
                        ),
                      ),
                      Row(
                        children: [/*
                          SizedBox(
                              height: 20,
                              width: 20,
                              child: (context
                                          .read<BackgroundCubit>()
                                          .state
                                          .data[hoverTileIndex] >=
                                      (context
                                                  .read<MetaTileCubit>()
                                                  .state
                                                  .data
                                                  .length ~/
                                              (context
                                                      .read<MetaTileCubit>()
                                                      .state
                                                      .height *
                                                  context
                                                      .read<MetaTileCubit>()
                                                      .state
                                                      .width)) +
                                          context
                                              .read<BackgroundCubit>()
                                              .state
                                              .origin)
                                  ? const Text('?')
                                  : MetaTileDisplay(
                                      tileData: context
                                          .read<MetaTileCubit>()
                                          .state
                                          .getTileAtIndex(context
                                              .read<BackgroundCubit>()
                                              .state
                                              .data[hoverTileIndex]))),*/
                          Text(
                              " $hoverTileIndexX/${context.read<BackgroundCubit>().state.width}:$hoverTileIndexY/${context.read<BackgroundCubit>().state.height}"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]);
    });
  }
}
