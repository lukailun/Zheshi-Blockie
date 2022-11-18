enum SubactivityStepType {
  login,
  registrationInfo,
  finish;

  String get value => () {
        switch (this) {
          case SubactivityStepType.login:
            return 'login';
          case SubactivityStepType.registrationInfo:
            return 'signup';
          case SubactivityStepType.finish:
            return 'finished_match';
        }
      }();
}
