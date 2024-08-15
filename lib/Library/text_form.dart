enum TextFormSubmissionStatus {
  initial,
  inProgress,
  success,
  failure,
  canceled
}

extension FormzSubmissionStatusX on TextFormSubmissionStatus {
  bool get isInitial => this == TextFormSubmissionStatus.initial;

  bool get isInProgress => this == TextFormSubmissionStatus.inProgress;

  bool get isSuccess => this == TextFormSubmissionStatus.success;

  bool get isFailure => this == TextFormSubmissionStatus.failure;

  bool get isCanceled => this == TextFormSubmissionStatus.canceled;

  /// Indicates whether the form is either in progress or has been submitted
  /// successfully.
  ///
  /// This is useful for showing a loading indicator or disabling the submit
  /// button to prevent duplicate submissions.
  bool get isInProgressOrSuccess => isInProgress || isSuccess;
}

abstract class TextFormInput<T, E> {
  final T value;
  final bool isPure;

  E? validator(T value);

  const TextFormInput._({required this.value, this.isPure = true});

  const TextFormInput.pure(T value) : this._(value: value);

  const TextFormInput.dirty(T value) : this._(value: value, isPure: false);

  bool get isValid => validator(value) == null;

  E? get error => validator(value);

  E? get displayError => isPure ? null : error;

  @override
  int get hashCode => Object.hashAll([value, isPure]);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is TextFormInput<T, E> &&
        other.value == value &&
        other.isPure == isPure;
  }

  @override
  String toString() {
    return isPure
        ? '''TextFormInput<$T, $E>.pure(value: $value, isValid: $isValid, error: $error)'''
        : '''TextFormInput<$T, $E>.dirty(value: $value, isValid: $isValid, error: $error)''';
  }
}

/// Mixin for [TextFormInput] that caches the [error] result of the [validator].
/// Use this mixin when implementations that make expensive computations are
/// used, such as those involving regular expressions.
mixin TextFormInputErrorCacheMixin<T, E> on TextFormInput<T, E> {
  late final E? _error = validator(value);

  @override
  E? get error => _error;

  @override
  bool get isValid => _error == null;
}

/// Class which contains methods that help manipulate and manage
/// validity of [TextFormInput] instances.
class TextForm {
  /// Returns a [bool] given a list of [TextFormInput] indicating whether
  /// the inputs are all valid.
  static bool validate(List<TextFormInput<dynamic, dynamic>> inputs) {
    return inputs.every((input) => input.isValid);
  }

  /// Returns a [bool] given a list of [TextFormInput] indicating whether
  /// all the inputs are pure.
  static bool isPure(List<TextFormInput<dynamic, dynamic>> inputs) {
    return inputs.every((input) => input.isPure);
  }
}

/// Mixin that automatically handles validation of all [TextFormInput]s present in
/// the [inputs].
///
/// When mixing this in, you are required to override the [inputs] getter and
/// provide all [TextFormInput]s you want to automatically validate.
///
/// ```dart
/// class LoginFormState with TextFormMixin {
///  LoginFormState({
///    this.username = const Username.pure(),
///    this.password = const Password.pure(),
///  });
///
///  final Username username;
///  final Password password;
///
///  @override
///  List<TextFormInput> get inputs => [username, password];
/// }
/// ```
mixin TextFormMixin {
  /// Whether the [TextFormInput] values are all valid.
  bool get isValid => TextForm.validate(inputs);

  /// Whether the [TextFormInput] values are not all valid.
  bool get isNotValid => !isValid;

  /// Whether all of the [TextFormInput] are pure.
  bool get isPure => TextForm.isPure(inputs);

  /// Whether at least one of the [TextFormInput]s is dirty.
  bool get isDirty => !isPure;

  /// Returns all [TextFormInput] instances.
  ///
  /// Override this and give it all [TextFormInput]s in your class that should be
  /// validated automatically.
  List<TextFormInput<dynamic, dynamic>> get inputs;
}
