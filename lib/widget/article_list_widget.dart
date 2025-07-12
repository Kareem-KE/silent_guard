import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/article.dart';

class ArticleListWidget extends StatelessWidget {
  final List<Article> articles;
  const ArticleListWidget({super.key, required this.articles});

  /*–––– helpers ––––*/
  String _fixYouTube(String url) {
    if (url.contains('youtube.com/embed/')) {
      final id = url.split('/embed/').last;
      return 'https://www.youtube.com/watch?v=$id';
    }
    return url;
  }

  Future<void> _launchURL(String? url) async {
    if (url == null || url.isEmpty) return;
    final uri = Uri.tryParse(_fixYouTube(url));
    if (uri == null) return;
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok) debugPrint('Could not launch: $url');
  }
  /*–––––––––––––––––*/

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // header avatar
          SizedBox(
            height: 100,
            width: 100,
            child: CircleAvatar(
              backgroundColor: colors.secondary,
              backgroundImage: const AssetImage(
                'assets/Images/zachary-kyra-derksen-0bDd5rZlZmk-unsplash.jpg',
              ),
            ),
          ),
          const SizedBox(height: 8),
          // articles list
          ListView.builder(
            itemCount: articles.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              final a = articles[i];
              return Card(
                elevation: 10,
                color: colors.onSecondary,
                shadowColor: colors.onPrimary,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // title
                      Text(
                        a.title,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.onPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      // description
                      Text(
                        a.description,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.secondary,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // info icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          _InfoRow(
                            icon: Icons.play_circle,
                            label: 'Watch Video',
                          ),
                          _InfoRow(
                            icon: Icons.menu_book,
                            label: 'Read Article',
                          ),
                        ],
                      ),
                      // link buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _LinkButton(onTap: () => _launchURL(a.videoUrl)),
                          _LinkButton(onTap: () => _launchURL(a.link)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/*──────── helper widgets ────────*/

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, color: colors.primary),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13),
        ),
      ],
    );
  }
}

class _LinkButton extends StatelessWidget {
  const _LinkButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(foregroundColor: colors.onPrimary),
      child: Text(
        'Click Here',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 17,
          color: colors.onPrimary,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
