enum VideoStatus {
  unknown,
  unrecorded,
  inProcess,
  successful,
  failed;

  int get value => () {
        switch (this) {
          case VideoStatus.unknown:
            return 0;
          case VideoStatus.unrecorded:
            return 1;
          case VideoStatus.inProcess:
            return 2;
          case VideoStatus.successful:
            return 3;
          case VideoStatus.failed:
            return 4;
        }
      }();
}
