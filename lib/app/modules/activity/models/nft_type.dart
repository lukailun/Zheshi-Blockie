enum NftType {
  sport,
  video;

  int get value => () {
        switch (this) {
          case NftType.sport:
            return 1;
          case NftType.video:
            return 2;
        }
      }();
}
