import 'package:flutter/material.dart';
import 'package:qbox_admin/models/level_up_series_model.dart';
import 'package:qbox_admin/widgets/level_up_question_paper_preview.dart';

class LevelUpHorizontalCard extends StatefulWidget {
  final LevelUpTestModel model;

  const LevelUpHorizontalCard({Key? key, required this.model})
      : super(key: key);

  @override
  State<LevelUpHorizontalCard> createState() => _LevelUpHorizontalCardState();
}

class _LevelUpHorizontalCardState extends State<LevelUpHorizontalCard> {
  int sl_no = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LevelUpQuestionPaperPreview(questionPaper: widget.model)),
        );
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: const EdgeInsets.all(2),
          width: 1200,
          padding: EdgeInsets.all(5),
          child: _dataList(),
        ),
      ),
    );
  }

  Widget _dataList() {
    sl_no = sl_no + 1;
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.white),
        child: DataTable(

            //border: TableBorder.symmetric(inside: BorderSide(width: 1.5,style: BorderStyle.solid,color: Colors.red)),
            columns: const [
              DataColumn(label: Text('Sl no.')),
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Course')),
              DataColumn(label: Text('Cid')),
              DataColumn(label: Text('Chapter')),
              DataColumn(label: Text('Duration')),
              DataColumn(label: Text('Exam Time')),
              DataColumn(label: Text('Paper Set')),
              DataColumn(label: Text('Test Name')),
            ], rows: [
          DataRow(
            color: MaterialStateColor.resolveWith((states) => Colors.black12),
            cells: <DataCell>[
              DataCell(Text('${sl_no}')),
              DataCell(Text(widget.model.category.toString())),
              DataCell(Text(widget.model.course.toString())),
              DataCell(Text(widget.model.cid.toString())),
              DataCell(Text(widget.model.chapter.toString())),
              DataCell(Text(widget.model.duration.toString())),
              DataCell(Text(widget.model.examTime.toString())),
              DataCell(Text(widget.model.paperSet.toString())),
              DataCell(Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.model.testName.toString()),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_right_alt,
                        color: Colors.blue,
                      ))
                ],
              )),
            ],
          )
        ]
        )
        );

    sl_no = 0;
  }
}
