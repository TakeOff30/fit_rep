import 'package:fit_rep/config.dart';
import 'package:fit_rep/enums.dart';
import 'package:fit_rep/models/exercise.dart';
import 'package:fit_rep/models/workout.dart';
import 'package:fit_rep/providers/settings_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Filter {
  String workoutNameFilter = '';
  List<String> musclesFilters = [];
  String exerciseTypeFilter = '';
  List<String> exercisesFilters = [];

  Filter(this.workoutNameFilter, this.musclesFilters, this.exerciseTypeFilter,
      this.exercisesFilters);

  List<Workout> filterWorkouts(List<Workout> workouts) {
    return workouts.where((workout) {
      List<String> workoutExercisesNames =
          workout.exercises.keys.map((e) => e.name).toList();
      if (workoutNameFilter != '' &&
          !workout.name
              .toLowerCase()
              .contains(workoutNameFilter.toLowerCase())) {
        return false;
      }
      if (musclesFilters != [] &&
          !musclesFilters
              .every((muscle) => workout.muscles().contains(muscle))) {
        return false;
      }
      if (exerciseTypeFilter != '' &&
          !workout.exerciseTypes().contains(exerciseTypeFilter)) {
        return false;
      }
      if (exercisesFilters != [] &&
          !exercisesFilters
              .every((element) => workoutExercisesNames.contains(element))) {
        return false;
      }
      return true;
    }).toList();
  }
}

class FilterCard extends StatefulWidget {
  final Filter filter;
  final Function(Filter) onFilterChanged;

  FilterCard(this.filter, this.onFilterChanged);

  @override
  _FilterCardState createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {
  final workoutNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    workoutNameController.text = widget.filter.workoutNameFilter;
  }

  @override
  void dispose() {
    workoutNameController.dispose();
    super.dispose();
  }

  final List<String> musclesList =
      Muscle.values.map((e) => e.name.toLowerCase()).toList();

  final List<String> exerciseTypeFilterList =
      ExerciseType.values.map((e) => e.name.toLowerCase()).toList();

  @override
  Widget build(BuildContext context) {
    var settingsManager = Provider.of<SettingsManager>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Filters'),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      widget.filter.workoutNameFilter = '';
                      widget.filter.musclesFilters = [];
                      widget.filter.exerciseTypeFilter = '';
                      workoutNameController.text =
                          widget.filter.workoutNameFilter;
                      widget.filter.exercisesFilters = [];
                      widget.onFilterChanged(widget.filter);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: workoutNameController,
                            decoration: InputDecoration(
                              hintText: 'Workout name',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            onChanged: (value) {
                              setState(() {
                                widget.filter.workoutNameFilter = value;
                                widget.onFilterChanged(widget.filter);
                              });
                            },
                          ),
                        ),
                        Builder(builder: (context) {
                          return DropdownButton<String>(
                            style: Theme.of(context).textTheme.bodyMedium,
                            dropdownColor: (settingsManager.isDarkMode)
                                ? Theme.of(context).primaryColorDark
                                : Theme.of(context).primaryColorLight,
                            isExpanded: true,
                            hint: Text('Trained muscles',
                                style: TextStyle(
                                    color: (settingsManager.isDarkMode)
                                        ? Theme.of(context).primaryColorLight
                                        : Theme.of(context).primaryColorDark)),
                            items: musclesList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                if (widget.filter.musclesFilters
                                    .contains(value!)) {
                                  widget.filter.musclesFilters.remove(value);
                                } else {
                                  widget.filter.musclesFilters.add(value!);
                                }
                                widget.onFilterChanged(widget.filter);
                              });
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<String>(
                          isExpanded: true,
                          style: Theme.of(context).textTheme.bodyMedium,
                          dropdownColor: (settingsManager.isDarkMode)
                              ? Theme.of(context).primaryColorDark
                              : Theme.of(context).primaryColorLight,
                          hint: Text('Included exercises',
                              style: TextStyle(
                                  color: (settingsManager.isDarkMode)
                                      ? Theme.of(context).primaryColorLight
                                      : Theme.of(context).primaryColorDark)),
                          items: fitRepExercises.map((Exercise exe) {
                            return DropdownMenuItem<String>(
                              value: exe.name,
                              child: Text(exe.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              if (widget.filter.exercisesFilters
                                  .contains(value!)) {
                                widget.filter.exercisesFilters.remove(value);
                              } else {
                                widget.filter.exercisesFilters.add(value!);
                              }
                              widget.onFilterChanged(widget.filter);
                            });
                          },
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          style: Theme.of(context).textTheme.bodyMedium,
                          dropdownColor: (settingsManager.isDarkMode)
                              ? Theme.of(context).primaryColorDark
                              : Theme.of(context).primaryColorLight,
                          hint: Text('Exercise type',
                              style: TextStyle(
                                  color: (settingsManager.isDarkMode)
                                      ? Theme.of(context).primaryColorLight
                                      : Theme.of(context).primaryColorDark)),
                          value: widget.filter.exerciseTypeFilter == ''
                              ? null
                              : widget.filter.exerciseTypeFilter,
                          items: exerciseTypeFilterList.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              widget.filter.exerciseTypeFilter = value!;
                              widget.onFilterChanged(widget.filter);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Wrap(
              children: <Widget>[
                ...widget.filter.exercisesFilters.map((exercise) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    child: Chip(
                      label: Text(exercise),
                      deleteIcon: Icon(Icons.cancel),
                      onDeleted: () {
                        setState(() {
                          widget.filter.exercisesFilters.remove(exercise);
                          widget.onFilterChanged(widget.filter);
                        });
                      },
                    ),
                  );
                }).toList(),
                ...widget.filter.musclesFilters.map((muscle) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    child: Chip(
                      label: Text(muscle),
                      deleteIcon: Icon(Icons.cancel),
                      onDeleted: () {
                        setState(() {
                          widget.filter.musclesFilters.remove(muscle);
                          widget.onFilterChanged(widget.filter);
                        });
                      },
                    ),
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
