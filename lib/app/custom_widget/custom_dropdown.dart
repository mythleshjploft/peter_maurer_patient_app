import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/colors/app_colors.dart';

class CustomDropdownButton2<T> extends StatelessWidget {
  final String hintText;
  final String searchHintText;
  final List<T> items;
  final T? value;
  final String Function(T)? displayText;
  final void Function(T?)? onChanged;
  final TextEditingController? searchController;
  final double? borderRadius;
  final bool hasError;

  const CustomDropdownButton2(
      {super.key,
      required this.hintText,
      this.searchHintText = '',
      required this.items,
      required this.value,
      required this.displayText,
      required this.onChanged,
      this.searchController,
      this.borderRadius,
      this.hasError = false});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: true,
        hint: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            hintText.tr,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem<T>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      displayText!(item),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ))
            .toList(),
        value: value,
        onChanged: onChanged,
        iconStyleData: const IconStyleData(
            icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.grayMedium,
        )),
        // icon: Image.asset(AppAssets.dropDownArrow,width: 16,height: 16,color: AppColors.blackColor,)),
        menuItemStyleData: const MenuItemStyleData(height: 40),
        buttonStyleData: ButtonStyleData(
          height: 60,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 12, right: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(borderRadius ?? 30),
            border: Border.all(
              color: hasError ? AppColors.errorColor : AppColors.primaryColor,
            ),

            // boxShadow: [boxShadowTextField()],
            // color: AppColors.whiteColor,
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 250,
          // width: 200,
          // width: MediaQuery.of(context).size.width*0.94,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.white,
          ),
        ),
        dropdownSearchData: searchController != null
            ? DropdownSearchData<T>(
                searchController: searchController!,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: searchController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: searchHintText,
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            const BorderSide(color: AppColors.grayMedium),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return displayText!(item.value as T)
                      .toLowerCase()
                      .contains(searchValue.toLowerCase());
                },
              )
            : null,
        // This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen && searchController != null) {
            searchController!.clear();
          }
        },
      ),
    );
  }
}
