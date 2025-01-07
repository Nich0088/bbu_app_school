import 'package:flutter/material.dart';

import '../../../modules/user_dashboard/model/study_result_item.dart';
import '../../app_setting.dart';

class StudyResultItemWidget extends StatelessWidget {
  final StudentScoreItem item;

  const StudyResultItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: AppColor.infoColor,
          padding: const EdgeInsets.only(
            left: 4,
            top: 4,
          ),
          child: Text(
            "${item.termTitle} (Term: ${item.term})",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            dataTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                ),
            horizontalMargin: 20,
            headingRowColor: const WidgetStatePropertyAll(Colors.blue),
            showCheckboxColumn: false,
            columnSpacing: 8,
            border: TableBorder.all(),
            columns: const [
              DataColumn(
                label: Center(
                  child: Text(
                    "No",
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  "Subject Name",
                ),
              ),
              DataColumn(
                label: Text(
                  "Midterm",
                ),
              ),
              DataColumn(
                label: Text(
                  "Final",
                ),
              ),
              DataColumn(
                label: Text(
                  "Credit",
                ),
              ),
              DataColumn(
                label: Text(
                  "Total",
                ),
              ),
              DataColumn(
                label: Text(
                  "GPV",
                ),
              ),
              DataColumn(
                label: Text(
                  "Grade",
                ),
              ),
            ],
            rows: item.subjectList
                .map(
                  (subject) => DataRow(
                    cells: [
                      DataCell(
                        Text(
                          subject.numberOrder.toString(),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: 96,
                          child: Text(
                            subject.name,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          subject.midtermResult.toString(),
                        ),
                      ),
                      DataCell(
                        Text(
                          subject.finalResult.toString(),
                        ),
                      ),
                      DataCell(
                        Text(
                          subject.credit.toString(),
                        ),
                      ),
                      DataCell(
                        Text(
                          subject.total.toString(),
                        ),
                      ),
                      DataCell(
                        Text(
                          subject.gpv.toString(),
                        ),
                      ),
                      DataCell(
                        Text(
                          subject.grade,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
