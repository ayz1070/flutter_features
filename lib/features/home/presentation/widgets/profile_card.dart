import 'package:flutter/material.dart';
import 'package:flutter_features/core/theme/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';
import '../vm/profile_view_model.dart';

class ProfileCard extends StatelessWidget {
  final ProfileViewModel profileViewModel;

  const ProfileCard({super.key, required this.profileViewModel});

  @override
  Widget build(BuildContext context) {
    final Uri _url = Uri.parse("https://github.com/ayz1070");

    return Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 4.0,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 프로필 이미지
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(profileViewModel.avatarUrl),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profileViewModel.name.isNotEmpty
                      ? profileViewModel.name
                      : profileViewModel.login,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8,),
                Text(
                  profileViewModel.bio,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16,),
                GestureDetector(
                  onTap: () async {
                    if (!await launchUrl(_url)) {
                      throw 'Could not launch $_url';
                    }
                    await launchUrl(_url);
                  },
                  child: Text(
                    '깃허브_링크',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoColumn('Repos', profileViewModel.publicRepos),
                    SizedBox(width: 20,),
                    _buildInfoColumn('Follower', profileViewModel.followers),
                    SizedBox(width: 20,),
                    _buildInfoColumn('Following', profileViewModel.following),
                  ],
                ),
              ],
            ),

            // 추가 정보
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, int count) {
    return Column(
      children: [
        Text(label, style: AppTextStyles.bold16,),
        Text(
          '$count',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
