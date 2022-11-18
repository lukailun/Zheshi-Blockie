enum NftType {
  sport,
  video,
  card,
  kettleBell;

  int get value => () {
        switch (this) {
          case NftType.sport:
            return 1;
          case NftType.video:
            return 2;
          case NftType.card:
            return 3;
          case NftType.kettleBell:
            return 4;
        }
      }();
}
