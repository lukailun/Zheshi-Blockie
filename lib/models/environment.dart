enum Environment {
  dev(
    title: 'BLOCKIE-DEV',
    baseUrl: 'https://s.blockie.zheshi.tech/api/v1',
    anyWebUrl: 'https://zheshi.tech/public/dist/',
  ),
  prod(
    title: 'BLOCKIE',
    baseUrl: 'https://api.blockie.fun/api/v1',
    anyWebUrl: 'https://app.blockie.fun/anyweblogin/v2210/index.html',
  );

  const Environment({
    required this.title,
    required this.baseUrl,
    required this.anyWebUrl,
  });

  final String title;
  final String baseUrl;
  final String anyWebUrl;
}
