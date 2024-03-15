import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_boy_graphics_editor/cubits/background_cubit.dart';
import 'package:game_boy_graphics_editor/models/graphics/background.dart';

import '../../cubits/app_state_cubit.dart';

class BackgroundProperties extends StatelessWidget {
  const BackgroundProperties({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BackgroundCubit, Background>(
        builder: (context, background) {
      return Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Name'),
            initialValue: context.read<AppStateCubit>().state.backgroundName,
            onChanged: (text) =>
                context.read<AppStateCubit>().setBackgroundName(text),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('^[0-9]*')),
                    ],
                    decoration: const InputDecoration(labelText: 'Width'),
                    key: Key(context.read<AppStateCubit>().state.tileName),
                    initialValue:
                        context.read<BackgroundCubit>().state.width.toString(),
                    onChanged: (text) => context
                        .read<BackgroundCubit>()
                        .setWidth(int.parse(text))),
              ),
              /*IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: 'Add Column',
                  onPressed: () =>
                      context.read<BackgroundCubit>().insertCol(0, 0)),
              IconButton(
                  icon: const Icon(Icons.remove),
                  tooltip: 'Remove Column',
                  onPressed: () => background.width > 1
                      ? context.read<BackgroundCubit>().deleteCol(0)
                      : null),*/
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('^[0-9]*')),
                    ],
                    decoration: const InputDecoration(labelText: 'Height'),
                    key: Key(context.read<AppStateCubit>().state.tileName),
                    initialValue:
                        context.read<BackgroundCubit>().state.height.toString(),
                    onChanged: (text) => context
                        .read<BackgroundCubit>()
                        .setHeight(int.parse(text))),
              ),
              /*IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: 'Add Row',
                  onPressed: () =>
                      context.read<BackgroundCubit>().insertRow(0, 0)),
              IconButton(
                  icon: const Icon(Icons.remove),
                  tooltip: 'Remove Row',
                  onPressed: () => background.height > 1
                      ? context.read<BackgroundCubit>().deleteRow(0)
                      : null),*/
            ],
          ),
          TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('^[0-9]*')),
              ],
              decoration: const InputDecoration(labelText: 'Origin'),
              key: const Key('tileOrigin'),
              initialValue:
                  context.read<BackgroundCubit>().state.tileOrigin.toString(),
              onChanged: (text) =>
                  context.read<BackgroundCubit>().setOrigin(int.parse(text))),
        ],
      );
    });
  }
}
