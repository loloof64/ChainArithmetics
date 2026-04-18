///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsPagesEn pages = TranslationsPagesEn._(_root);
}

// Path: pages
class TranslationsPagesEn {
	TranslationsPagesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsPagesCommonEn common = TranslationsPagesCommonEn._(_root);
	late final TranslationsPagesHomeEn home = TranslationsPagesHomeEn._(_root);
	late final TranslationsPagesStandardExercisesEn standard_exercises = TranslationsPagesStandardExercisesEn._(_root);
}

// Path: pages.common
class TranslationsPagesCommonEn {
	TranslationsPagesCommonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Timeout !'
	String get timeout => 'Timeout !';

	/// en: 'Remaining time : $remainingTimeSec s'
	String remaining_time({required Object remainingTimeSec}) => 'Remaining time : ${remainingTimeSec} s';

	/// en: 'Elapsed time : ${elapsedMinutes}m ${elapedSeconds}s'
	String elapsed_time({required Object elapsedMinutes, required Object elapedSeconds}) => 'Elapsed time : ${elapsedMinutes}m ${elapedSeconds}s';

	late final TranslationsPagesCommonPenaltyEn penalty = TranslationsPagesCommonPenaltyEn._(_root);
}

// Path: pages.home
class TranslationsPagesHomeEn {
	TranslationsPagesHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get title => 'Home';

	late final TranslationsPagesHomeButtonsEn buttons = TranslationsPagesHomeButtonsEn._(_root);
}

// Path: pages.standard_exercises
class TranslationsPagesStandardExercisesEn {
	TranslationsPagesStandardExercisesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsPagesStandardExercisesHomeEn home = TranslationsPagesStandardExercisesHomeEn._(_root);
	late final TranslationsPagesStandardExercisesThirtyQuestionsEn thirtyQuestions = TranslationsPagesStandardExercisesThirtyQuestionsEn._(_root);
	late final TranslationsPagesStandardExercisesOneHundredQuestionsEn oneHundredQuestions = TranslationsPagesStandardExercisesOneHundredQuestionsEn._(_root);
}

// Path: pages.common.penalty
class TranslationsPagesCommonPenaltyEn {
	TranslationsPagesCommonPenaltyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Penalty: $penaltyCount * ${penaltyTimeSeconds}s = ${totalPenaltyTimeSeconds}s'
	String one_minute_mode({required Object penaltyCount, required Object penaltyTimeSeconds, required Object totalPenaltyTimeSeconds}) => 'Penalty: ${penaltyCount} * ${penaltyTimeSeconds}s = ${totalPenaltyTimeSeconds}s';

	/// en: 'Penalty: $penaltyCount * ${penaltyTimeSeconds}s = ${totalPenaltyTimeMinutes}m ${totalPenaltyTimeSeconds}s'
	String one_hundred_questions_mode({required Object penaltyCount, required Object penaltyTimeSeconds, required Object totalPenaltyTimeMinutes, required Object totalPenaltyTimeSeconds}) => 'Penalty: ${penaltyCount} * ${penaltyTimeSeconds}s = ${totalPenaltyTimeMinutes}m ${totalPenaltyTimeSeconds}s';
}

// Path: pages.home.buttons
class TranslationsPagesHomeButtonsEn {
	TranslationsPagesHomeButtonsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Standard'
	String get standard_exercises => 'Standard';
}

// Path: pages.standard_exercises.home
class TranslationsPagesStandardExercisesHomeEn {
	TranslationsPagesStandardExercisesHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Standard calculation'
	String get title => 'Standard calculation';

	/// en: '1 min questions'
	String get gotoThirtyQuestions => '1 min questions';

	/// en: '100 questions'
	String get gotoOneHundredQuestions => '100 questions';
}

// Path: pages.standard_exercises.thirtyQuestions
class TranslationsPagesStandardExercisesThirtyQuestionsEn {
	TranslationsPagesStandardExercisesThirtyQuestionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Calculation: $oneMinuteModeQuestionsCount questions / 1 min'
	String title({required Object oneMinuteModeQuestionsCount}) => 'Calculation: ${oneMinuteModeQuestionsCount} questions / 1 min';
}

// Path: pages.standard_exercises.oneHundredQuestions
class TranslationsPagesStandardExercisesOneHundredQuestionsEn {
	TranslationsPagesStandardExercisesOneHundredQuestionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Calculation: 100 questions'
	String get title => 'Calculation: 100 questions';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'pages.common.timeout' => 'Timeout !',
			'pages.common.remaining_time' => ({required Object remainingTimeSec}) => 'Remaining time : ${remainingTimeSec} s',
			'pages.common.elapsed_time' => ({required Object elapsedMinutes, required Object elapedSeconds}) => 'Elapsed time : ${elapsedMinutes}m ${elapedSeconds}s',
			'pages.common.penalty.one_minute_mode' => ({required Object penaltyCount, required Object penaltyTimeSeconds, required Object totalPenaltyTimeSeconds}) => 'Penalty: ${penaltyCount} * ${penaltyTimeSeconds}s = ${totalPenaltyTimeSeconds}s',
			'pages.common.penalty.one_hundred_questions_mode' => ({required Object penaltyCount, required Object penaltyTimeSeconds, required Object totalPenaltyTimeMinutes, required Object totalPenaltyTimeSeconds}) => 'Penalty: ${penaltyCount} * ${penaltyTimeSeconds}s = ${totalPenaltyTimeMinutes}m ${totalPenaltyTimeSeconds}s',
			'pages.home.title' => 'Home',
			'pages.home.buttons.standard_exercises' => 'Standard',
			'pages.standard_exercises.home.title' => 'Standard calculation',
			'pages.standard_exercises.home.gotoThirtyQuestions' => '1 min questions',
			'pages.standard_exercises.home.gotoOneHundredQuestions' => '100 questions',
			'pages.standard_exercises.thirtyQuestions.title' => ({required Object oneMinuteModeQuestionsCount}) => 'Calculation: ${oneMinuteModeQuestionsCount} questions / 1 min',
			'pages.standard_exercises.oneHundredQuestions.title' => 'Calculation: 100 questions',
			_ => null,
		};
	}
}
