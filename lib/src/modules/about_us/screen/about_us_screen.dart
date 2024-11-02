import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../constants/app_setting.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        backgroundColor: AppColor.primaryColor,
        isDashboardAppBar: false,
        title: "About Us",
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
              Text(
                'The University Background',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 15, color: Colors.black),
                  children: const <TextSpan>[
                    TextSpan(
                      text:
                          'With a humble beginning in 2000 as a Faculty of Management and Law (FML), today, Build Bright University (BBU) is one of the leading universities in Cambodia having its eight campuses in different parts of the country. Along with the central campus at Phnom Penh, the other provincial campuses are at Siem Reap, Battambang, Banteay Meanchey, Preah Sihanouk, Takeo, Rattanakiri and Stung Treng. The university is recognized by the Ministry of Education, Youth and Sport of the Royal Government of Cambodia. Guided by the vision of  ',
                    ),
                    TextSpan(
                      text: 'H.E. Dr. In Viracheat ,',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          ' since 2002, BBU has been marching ahead toward meeting its social commitment.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16), // Adds spacing between titles
              Text(
                'Realizing the need of trained and skilled workforce for the country as well as the region, BBU through its several faculties and school offers Associate, Bachelor, Master and Doctoral programs as approved by the Ministry of Education, Youth and Sport. In addition, the university regularly conducts client-based training programs, research and consultancies. The university has the credibility of successfully placing its graduates in public, private and non-government organizations.',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 16),
              Text(
                'Geographical Location',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 16), // Adds spacing between titles
              Text(
                'All three campuses remain in the heart of Phnom Penh capital, where most activities related to commercial trades, businesses, social/cultural/sport events, public services, government & non-governmental administrations, and tourist activities are concentrated. Interestingly, the main campus, Tonle Basac campus is located on the south-central part of Cambodia, at the confluence of the Tonle Sap and Mekong rivers, where students can enjoy the river view, city theme parks and green landscapes. Phnom Penh is the largest, most populous, and is home to about 2 million of Cambodia s population of 13.8 million.',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 16), // Adds spacing between titles
              Text(
                'BBU Tonle Basac campus is a six-storey building, built on 60m x 450m land space and located at: Grey building, Samdech Sothearos blvd, Sangkat Tonle basac, Khan Chankarmon, Near Samdech Hunsen Park, Phnom Penh. BBU Toul Svay Prey campus is a three-storey building, built on 12m x 16m land space and located at: # 49S, street 205 across 356, Sangkat Toul Svay Prey II, Khan Chamkarmon, Phnom Penh.',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 16), // Adds spacing between titles
              Text(
                'BBU Daun Penh campus is a four-storey building, built on 12m x 32m land space and located at: # 28, Street. 184 or 200, Sangkat Phsar Thmei III, Khan Duan Penh, Phnom Penh.',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 16),
              Text(
                'Administrators',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 16), // Adds spacing between titles
              Text(
                'The BBU’s Phnom Penh Campus is run and managed under the leadership of Rector and Vice-rectors. Additionally, there are also President and one Vice-president who coordinate between the offices. Phnom Penh Campus has a total of 147 staffs working full time in 25 different offices: Accounting Office, Treasury Office, Inventory and Logistic Office, Registration Office, Internal Audit Office, Academic Office, Statistic Office, Continuous Study Office, Examination Control Office, Administration Office, Human Resource Office, Rector Office, Research and Development Office, Operation and Maintenance Office, Training and Information Technology Office, Information System Development, and Information and Communication Technology Office, Legal and Coordination Office, Quality Assurance Office, Student Service Office, Health Service Office, Sports Office, Information Service Office, Post Graduate Office and International Study Office.Each of the offices is managed by the Head and a Deputy Head of office. These 25 Offices have different work but they closely coordinate to provide a smooth flow of work. They are the backbone to support to the students and the teaching staff.',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 16),
              Text(
                'Education Focus',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 16), // Adds spacing between titles
              Text(
                'Phnom Penh is the capital city of Cambodia. It is the largest and the most populous part of the country. It is a significant global and domestic tourist destination and also the commercial, political and cultural hub of Cambodia. It is home to about 2 million of Cambodia s population of 13.8 million. Based on the multi-ethnic region, the education Program in Phnom Penh Campus is also adapted and designed distinctively. The teaching curriculum and education programs have been designed to meet the diversity of needs. Phnom Penh Campus offers the following degrees: Associate Degree, Bachelor Degree, Master Degree and Doctoral Degree. For Associate and bachelor degrees, there are six faculties such as Faculty of Business Management, Faculty of Tourism and Hospitality, Faculty of Sciences and Technology, Faculty of Education and Languages, Faculty of Law and Sciences and Department of Foundation year',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: '.',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 20, color: Colors.black),
                    ),
                    const TextSpan(
                      text:
                          'The fields in the Faculty of Business Management are Accounting, Finance and Banking, Marketing, Project and Program Development, Economic, International Business Management.',
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: '.',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 20, color: Colors.black),
                    ),
                    const TextSpan(
                      text:
                          'The fields in the Faculty of Business Management are Accounting, Finance and Banking, Marketing, Project and Program Development, Economic, International Business Management.',
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: '.',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 20, color: Colors.black),
                    ),
                    const TextSpan(
                      text:
                          'The fields in the Faculty of Business Management are Accounting, Finance and Banking, Marketing, Project and Program Development, Economic, International Business Management.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16), // Adds spacing between titles
              Text(
                'In order to conform to the requirement of Accreditation Committee of Cambodia (ACC), The Phnom Penh Campus has started implementing its Foundation Year Program since academic year 2005-2006 and recognized to issue the Foundation Year Certificates to the students upon completion of the program. The well designed programs and curriculums offer the students good opportunity to be employed in their fields of specialization.',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 16),
              Text(
                'Enrollment',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 16),
              Text(
                'Since the first academic year 2000 -2001 until now, Phnom Penh Campus has offered the education service to more than 10000 students on several degrees such as Associate degree, Bachelor Degree, Master Degree, and Doctoral Degree. For this academic year 2006-2007, there are about 2000 students who enrolled in Phnom Penh Campus.',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 16),
              Text(
                'New students register for classes for each promotion and by each stage as determined by Build Bright University. They register one week before classes start. Registration dates are listed on the academic Calendar which is available in the Academic Service Department. Students register according to their year of study. The Registration period is three to seven days long.',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 16),
              Text(
                'Students who register for associate degree must have their high school certificate, or equivalent documents. Bachelor degree must have their high school certificate or equivalent document; Master degree must have their Bachelor certificate or equivalent document; Doctoral degree must have their Master degree or equivalent documents. The staff usually assist new students to ensure that they fill in the registration form correctly.',
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
