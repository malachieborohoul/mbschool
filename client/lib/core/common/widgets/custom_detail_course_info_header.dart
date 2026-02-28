import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mbschool/core/constants/colors.dart';
import 'package:mbschool/core/constants/padding.dart';
import 'package:mbschool/core/constants/utils.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/cours.dart';

class CustomDetailCourseInfoHeader extends StatefulWidget {
  final Cours cours;
  // Marked as final to fix the 'must_be_immutable' error
  final bool initialIsCourseInFav; 
  final double averageRate;

  const CustomDetailCourseInfoHeader({
    super.key,
    required this.cours,
    required this.initialIsCourseInFav,
    required this.averageRate, required bool isCourseInFav,
  });

  @override
  State<CustomDetailCourseInfoHeader> createState() =>
      _CustomDetailCourseInfoHeaderState();
}

class _CustomDetailCourseInfoHeaderState
    extends State<CustomDetailCourseInfoHeader> {
  final CourseManagerService _courseManagerService = CourseManagerService();

  late bool isFavorite;
  bool isCharging = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialIsCourseInFav;
  }

  // Refactored Dialog Logic to avoid code duplication
  void _showToggleFavoriteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Notification"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isFavorite 
                ? "Voulez-vous le retirer des favoris ?" 
                : "Voulez-vous l'ajouter aux favoris ?",
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: appPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _dialogButton("Oui", Colors.green, () {
                  Navigator.pop(context);
                  isFavorite ? removeCoursToFavorite() : addCoursToFavorite();
                }),
                _dialogButton("Non", Colors.red, () => Navigator.pop(context)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _dialogButton(String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.grey.shade200,
      child: Container(
        alignment: Alignment.center,
        width: 60, // Increased for better touch target
        height: 35,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(label, style: const TextStyle(color: textWhite)),
      ),
    );
  }

  void addCoursToFavorite() {
    setState(() => isCharging = true);
    _courseManagerService.addCourseToFavorite(context, widget.cours, () {
      if (mounted) {
        setState(() {
          isFavorite = true;
          isCharging = false;
        });
        showSnackBar(context, "Cours ajouté aux favoris");
      }
    });
  }

  void removeCoursToFavorite() {
    setState(() => isCharging = true);
    _courseManagerService.removeCoursToFavorite(context, widget.cours, () {
      if (mounted) {
        setState(() {
          isFavorite = false;
          isCharging = false;
        });
        showSnackBar(context, "Cours retiré des favoris");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          right: appPadding, left: appPadding, top: appPadding / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.cours.titre,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  RatingBarIndicator(
                    rating: widget.averageRate,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: third,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.averageRate.toStringAsFixed(1),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              IconButton(
                onPressed: isCharging ? null : _showToggleFavoriteDialog,
                icon: isCharging
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                        color: Colors.red,
                      ),
              )
            ],
          ),
        ],
      ),
    );
  }
}