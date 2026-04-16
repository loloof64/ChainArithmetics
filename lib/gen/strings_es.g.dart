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
class TranslationsEs with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsPagesEs pages = _TranslationsPagesEs._(_root);
}

// Path: pages
class _TranslationsPagesEs implements TranslationsPagesEn {
	_TranslationsPagesEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPagesCommonEs common = _TranslationsPagesCommonEs._(_root);
	@override late final _TranslationsPagesHomeEs home = _TranslationsPagesHomeEs._(_root);
	@override late final _TranslationsPagesStandardExercisesEs standard_exercises = _TranslationsPagesStandardExercisesEs._(_root);
}

// Path: pages.common
class _TranslationsPagesCommonEs implements TranslationsPagesCommonEn {
	_TranslationsPagesCommonEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get timeout => '¡Tiempo agotado!';
	@override String remaining_time({required Object remainingTimeSec}) => 'Tiempo restante: ${remainingTimeSec} s';
	@override String penalty({required Object penaltyCount, required Object penaltyTimeSeconds, required Object totalPenaltyTimeSeconds}) => 'Penalización: ${penaltyCount} * ${penaltyTimeSeconds}s = ${totalPenaltyTimeSeconds}s';
}

// Path: pages.home
class _TranslationsPagesHomeEs implements TranslationsPagesHomeEn {
	_TranslationsPagesHomeEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Inicio';
	@override late final _TranslationsPagesHomeButtonsEs buttons = _TranslationsPagesHomeButtonsEs._(_root);
}

// Path: pages.standard_exercises
class _TranslationsPagesStandardExercisesEs implements TranslationsPagesStandardExercisesEn {
	_TranslationsPagesStandardExercisesEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPagesStandardExercisesHomeEs home = _TranslationsPagesStandardExercisesHomeEs._(_root);
	@override late final _TranslationsPagesStandardExercisesThirtyQuestionsEs thirty_questions = _TranslationsPagesStandardExercisesThirtyQuestionsEs._(_root);
}

// Path: pages.home.buttons
class _TranslationsPagesHomeButtonsEs implements TranslationsPagesHomeButtonsEn {
	_TranslationsPagesHomeButtonsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get standard_exercises => 'Estándar';
}

// Path: pages.standard_exercises.home
class _TranslationsPagesStandardExercisesHomeEs implements TranslationsPagesStandardExercisesHomeEn {
	_TranslationsPagesStandardExercisesHomeEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cálculo estándar';
	@override String get gotoThirtyQuestions => 'Preguntas sobre 1 min';
}

// Path: pages.standard_exercises.thirty_questions
class _TranslationsPagesStandardExercisesThirtyQuestionsEs implements TranslationsPagesStandardExercisesThirtyQuestionsEn {
	_TranslationsPagesStandardExercisesThirtyQuestionsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cálculo: 35 preguntas / 1 min';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'pages.common.timeout' => '¡Tiempo agotado!',
			'pages.common.remaining_time' => ({required Object remainingTimeSec}) => 'Tiempo restante: ${remainingTimeSec} s',
			'pages.common.penalty' => ({required Object penaltyCount, required Object penaltyTimeSeconds, required Object totalPenaltyTimeSeconds}) => 'Penalización: ${penaltyCount} * ${penaltyTimeSeconds}s = ${totalPenaltyTimeSeconds}s',
			'pages.home.title' => 'Inicio',
			'pages.home.buttons.standard_exercises' => 'Estándar',
			'pages.standard_exercises.home.title' => 'Cálculo estándar',
			'pages.standard_exercises.home.gotoThirtyQuestions' => 'Preguntas sobre 1 min',
			'pages.standard_exercises.thirty_questions.title' => 'Cálculo: 35 preguntas / 1 min',
			_ => null,
		};
	}
}
