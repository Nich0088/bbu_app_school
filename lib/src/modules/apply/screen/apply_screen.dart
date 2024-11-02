import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../constants/app_setting.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen({super.key});

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        backgroundColor: AppColor.primaryColor,
        isDashboardAppBar: false,
        title: "Apply Online",
        isCenterTitle: true,
        onPressedBack: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 24),
                child: Text(
                  'Undergraduate Programmer ',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                " General Requirement ",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 16),
              Text(
                "The applicant for Associate program must have high school diploma or equivalent degree or a certificate certifying that he/she did not pass the high school examination. The applicant for Bachelor program must have high school diploma or equivalent degree from a duly recognized school.",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 16),
              Text(
                " How to Apply",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 16),
              Text(
                "Build Bright University offers walk-in application on arrival at any of the campuses of the university and new students register for classes during the opening week. The prospective students must:",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                // Adjust padding as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ". Have transcript from any school which is recognized by Ministry of Education, Youth and Sports.",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 15, color: Colors.black),
                    ),
                    Text(
                      ". Fill out the admission application form, specify the program, faculty, major etc., sign their name, application date and attach three 4 x 6 cm. photographs.",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 15, color: Colors.black),
                    ),
                    Text(
                      ". Submit the application form and documents for admission along with tuition fee depend on the program.",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Grading System",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 16),
              Text(
                "All required study programmes, comprehensive examinations, Assignments, Projects, Thesis and Dissertations are graded by faculties and sent to the academic administration. Different levels of achievement are graded as follows: A Grade Point Average C is required for graduation in undergraduate studies",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 18),
              Text(
                "Postgraduate Programmer",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                // Adjust padding as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ". General Requirement for Admission",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 15, color: Colors.black),
                    ),
                    Text(
                      ". How to Apply",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 15, color: Colors.black),
                    ),
                    Text(
                      ". Tuition Fees",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 15, color: Colors.black),
                    ),
                    Text(
                      ". Grading System",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Text(
                "General Requirement",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 18),
              Text(
                "The applicant for Master degree must have a bachelor degree in respective discipline or related area in which he/she is interested to pursue the study he/she must graduate from recognized institute.",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 18),
              Text(
                "How to Apply",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 18),
              Text(
                "Build Bright University offers walk-in application on arrival at any of the campuses of the university and new students register for classes during the opening week. The prospective students mustHave transcript from any school which is recognized by Ministry of Education, Youth and SportsFill out the admission application form, specify the program, faculty, major etc., sign their name, application date and attach three 4 x 6 cm. photographs.Submit the application form and documents for admission along with tuition fee depending on the program.",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 18),
              Text(
                "Grading System",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 18),
              Text(
                "All required study programmes, comprehensive examinations, Assignments, Projects, Thesis and Dissertations are graded by faculties and are sent to the academic administration.Different levels of achievement are graded as follows:A Grade Point Average C+ is required for graduation in post-graduate studies.",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
