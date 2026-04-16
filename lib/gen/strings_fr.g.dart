///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsFr with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsFr _root = this; // ignore: unused_field

	@override 
	TranslationsFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFr(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsPagesFr pages = _TranslationsPagesFr._(_root);
}

// Path: pages
class _TranslationsPagesFr implements TranslationsPagesEn {
	_TranslationsPagesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPagesCommonFr common = _TranslationsPagesCommonFr._(_root);
	@override late final _TranslationsPagesHomeFr home = _TranslationsPagesHomeFr._(_root);
	@override late final _TranslationsPagesStandardExercisesFr standard_exercises = _TranslationsPagesStandardExercisesFr._(_root);
}

// Path: pages.common
class _TranslationsPagesCommonFr implements TranslationsPagesCommonEn {
	_TranslationsPagesCommonFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get timeout => 'Temps écoulé !';
	@override String remaining_time({required Object remainingTimeSec}) => 'Temps restant : ${remainingTimeSec} s';
	@override String penalty({required Object penaltyCount, required Object penaltyTimeSeconds, required Object totalPenaltyTimeSeconds}) => 'Penalité: ${penaltyCount} * ${penaltyTimeSeconds}s = ${totalPenaltyTimeSeconds}s';
}

// Path: pages.home
class _TranslationsPagesHomeFr implements TranslationsPagesHomeEn {
	_TranslationsPagesHomeFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Accueil';
	@override late final _TranslationsPagesHomeButtonsFr buttons = _TranslationsPagesHomeButtonsFr._(_root);
}

// Path: pages.standard_exercises
class _TranslationsPagesStandardExercisesFr implements TranslationsPagesStandardExercisesEn {
	_TranslationsPagesStandardExercisesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPagesStandardExercisesHomeFr home = _TranslationsPagesStandardExercisesHomeFr._(_root);
	@override late final _TranslationsPagesStandardExercisesThirtyQuestionsFr thirtyQuestions = _TranslationsPagesStandardExercisesThirtyQuestionsFr._(_root);
	@override late final _TranslationsPagesStandardExercisesOneHundredQuestionsFr oneHundredQuestions = _TranslationsPagesStandardExercisesOneHundredQuestionsFr._(_root);
}

// Path: pages.home.buttons
class _TranslationsPagesHomeButtonsFr implements TranslationsPagesHomeButtonsEn {
	_TranslationsPagesHomeButtonsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get standard_exercises => 'Standard';
}

// Path: pages.standard_exercises.home
class _TranslationsPagesStandardExercisesHomeFr implements TranslationsPagesStandardExercisesHomeEn {
	_TranslationsPagesStandardExercisesHomeFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Calcul standard';
	@override String get gotoThirtyQuestions => 'Questions sur 1 min';
	@override String get gotoOneHundredQuestions => '100 questions';
}

// Path: pages.standard_exercises.thirtyQuestions
class _TranslationsPagesStandardExercisesThirtyQuestionsFr implements TranslationsPagesStandardExercisesThirtyQuestionsEn {
	_TranslationsPagesStandardExercisesThirtyQuestionsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Calcul: 35 questions / 1 min';
}

// Path: pages.standard_exercises.oneHundredQuestions
class _TranslationsPagesStandardExercisesOneHundredQuestionsFr implements TranslationsPagesStandardExercisesOneHundredQuestionsEn {
	_TranslationsPagesStandardExercisesOneHundredQuestionsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Calcul: 100 questions';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'pages.common.timeout' => 'Temps écoulé !',
			'pages.common.remaining_time' => ({required Object remainingTimeSec}) => 'Temps restant : ${remainingTimeSec} s',
			'pages.common.penalty' => ({required Object penaltyCount, required Object penaltyTimeSeconds, required Object totalPenaltyTimeSeconds}) => 'Penalité: ${penaltyCount} * ${penaltyTimeSeconds}s = ${totalPenaltyTimeSeconds}s',
			'pages.home.title' => 'Accueil',
			'pages.home.buttons.standard_exercises' => 'Standard',
			'pages.standard_exercises.home.title' => 'Calcul standard',
			'pages.standard_exercises.home.gotoThirtyQuestions' => 'Questions sur 1 min',
			'pages.standard_exercises.home.gotoOneHundredQuestions' => '100 questions',
			'pages.standard_exercises.thirtyQuestions.title' => 'Calcul: 35 questions / 1 min',
			'pages.standard_exercises.oneHundredQuestions.title' => 'Calcul: 100 questions',
			_ => null,
		};
	}
}
