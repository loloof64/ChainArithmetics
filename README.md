# Chain arithmetics

[![Main Workflow](https://github.com/loloof64/ChainArithmetics/actions/workflows/main_workflow.yml/badge.svg)](https://github.com/loloof64/ChainArithmetics/actions/workflows/main_workflow.yml)

Simple arithmetic, but be very fast.

There are two types of computation : guess the result and guess the missing operator.
And for each type of computation, you can either try to answer 35 questions in 1 minute, or try to answer 100 questions under 5 minutes.

## For developers

### Linux dependencies

On linux, you will need dependencies to GStreamers 1.0 dev and GStreamers plugins 1.0 dev.
So, if on Debian based linux, you can run

```
sudo apt install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev -y
```

### Translations

Generate translations with command `dart run slang` in the root of the project.

### Icon

Generate launcher icon

```dart
flutter pub get
dart run flutter_launcher_icons
```

### Build for Android

1. Create a keystore file : chain_arithmetics.jks
2. Place it in android/app folder
3. Add a file android/key.properties

```groovy
storePassword=<password-from-previous-step>
keyPassword=<password-from-previous-step>
keyAlias=upload
storeFile=<keystore-file-location>
```

4. Run `flutter build appbundle`

## Credits

### Sounds

Got sounds from [FreeSound](https://freesound.org/)

- https://freesound.org/people/Beetlemuse/sounds/528957/
- https://freesound.org/people/unadamlar/sounds/476177/
- https://freesound.org/people/qubodup/sounds/832414/

### Icon

Icon has been downloaded from [SVG Repo](https://www.svgrepo.com/svg/444886/calculator)
