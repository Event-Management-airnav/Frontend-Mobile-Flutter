// popup_detail_presence_responsive.dart
import 'package:flutter/material.dart';

enum PresenceStatus { present, absent, disabled }

class PopupDetailPresence extends StatefulWidget {
  final List<PresenceStatus> statusPerSession;
  final String title;

  const PopupDetailPresence({
    super.key,
    required this.statusPerSession,
    this.title = 'Presensi Sesi Acara',
  });

  @override
  State<PopupDetailPresence> createState() =>
      _PopupDetailPresenceState();
}

class _PopupDetailPresenceState
    extends State<PopupDetailPresence> {
  int activeStep = 0;

  static const double _desiredItemWidth = 120; // lebar ideal tiap step (responsif)

  Widget _iconForStatus(PresenceStatus status, bool isActive) {
    const double size = 36;
    switch (status) {
      case PresenceStatus.present:
        return CircleAvatar(
          radius: size / 2,
          backgroundColor: Colors.green,
          child: const Icon(Icons.check, color: Colors.white, size: 18),
        );
      case PresenceStatus.absent:
        return CircleAvatar(
          radius: size / 2,
          backgroundColor: Colors.red,
          child: const Icon(Icons.close, color: Colors.white, size: 18),
        );
      case PresenceStatus.disabled:
      default:
        return CircleAvatar(
          radius: size / 2,
          backgroundColor: Colors.grey.shade300,
          child: Icon(Icons.circle, color: Colors.grey.shade400, size: 12),
        );
    }
  }

  TextStyle _labelStyle(PresenceStatus status) {
    switch (status) {
      case PresenceStatus.present:
        return const TextStyle(color: Colors.black, fontWeight: FontWeight.w600);
      case PresenceStatus.absent:
        return const TextStyle(color: Colors.red, fontWeight: FontWeight.w600);
      case PresenceStatus.disabled:
      default:
        return TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w600);
    }
  }

  List<List<int>> _chunkIndices(int count, int perRow) {
    final rows = <List<int>>[];
    for (var i = 0; i < count; i += perRow) {
      rows.add(
          List<int>.generate((i + perRow > count ? count - i : perRow), (j) => i + j));
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    final statuses = widget.statusPerSession;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: LayoutBuilder(builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final itemsPerRow =
          maxWidth >= _desiredItemWidth ? (maxWidth ~/ _desiredItemWidth) : 1;
          final rows = _chunkIndices(statuses.length, itemsPerRow);

          // actual itemWidth depends on available space (distribute evenly)
          final itemWidth = (maxWidth - 16) / (itemsPerRow); // minus some padding

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
              const SizedBox(height: 12),

              // stepper build rows
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var rowIndex = 0; rowIndex < rows.length; rowIndex++) ...[
                    // Row of items with horizontal connectors between items in same row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (var col = 0; col < rows[rowIndex].length; col++) ...[
                          _buildStepItem(
                            index: rows[rowIndex][col],
                            width: itemWidth,
                          ),
                          // if not last item in row, draw horizontal connector
                          if (col != rows[rowIndex].length - 1)
                            Expanded(
                              child: Container(
                                height: 2,
                                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 17),
                                color: Colors.grey.shade300,
                              ),
                            )
                        ]
                      ],
                    ),

                    // if there is a next row, draw vertical connectors aligned to columns that exist in next row
                    if (rowIndex != rows.length - 1)
                      SizedBox(
                        height: 28,
                        child: Row(
                          children: [
                            for (var col = 0; col < itemsPerRow; col++) ...[
                              SizedBox(
                                width: itemWidth,
                                child: Center(
                                  child: Builder(builder: (context) {
                                    // determine if current row has an item at this col, and next row has item at same col
                                    final curRowHas = col < rows[rowIndex].length;
                                    final nextRowHas = col < rows[rowIndex + 1].length;
                                    if (curRowHas && nextRowHas) {
                                      return Container(
                                        width: 2,
                                        height: 28,
                                        color: Colors.grey.shade300,
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  }),
                                ),
                              ),
                              // if col < itemsPerRow -1, we need to leave space for horizontal connector area as we used Expanded earlier
                              if (col != itemsPerRow - 1)
                                const SizedBox(width: 16), // spacing under horizontal connectors
                            ]
                          ],
                        ),
                      )
                  ]
                ],
              ),

              const SizedBox(height: 12),
              // legend
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _legendItem(Colors.green, Icons.check, 'Hadir'),
                  _legendItem(Colors.red, Icons.close, 'Tidak Hadir'),
                  _legendItem(Colors.grey.shade300, Icons.circle, 'Belum'),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildStepItem({required int index, required double width}) {
    final status = widget.statusPerSession[index];
    final label = 'Sesi ${index + 1}';
    final isActive = index == activeStep;

    return SizedBox(
      width: width,
      child: InkWell(
        onTap: status == PresenceStatus.disabled
            ? null
            : () {
          setState(() => activeStep = index);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // icon with a small shadow when active
            Container(
              padding: const EdgeInsets.all(2),
              decoration: isActive
                  ? BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 6)],
              )
                  : null,
              child: _iconForStatus(status, isActive),
            ),
            const SizedBox(height: 8),
            Text(label, style: _labelStyle(status)),
          ],
        ),
      ),
    );
  }

  Widget _legendItem(Color bgColor, IconData icon, String label) {
    return Row(
      children: [
        CircleAvatar(radius: 12, backgroundColor: bgColor, child: Icon(icon, size: 14, color: Colors.white)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
