extension DateTimeExtension on DateTime {
  String get constellation {
    const aries = '白羊座'; // 白羊座（3月21日～4月20日）
    const taurus = '金牛座'; // 金牛座（4月21～5月21日）
    const gemini = '双子座'; // 双子座（5月22日～6月21日）
    const cancer = '巨蟹座'; // 巨蟹座（6月22日～7月22日）
    const leo = '狮子座'; // 狮子座（7月23日～8月23日）
    const virgo = '处女座'; // 处女座（8月24日～9月23日）
    const libra = '天秤座'; // 天秤座（9月24日～10月23日）
    const scorpio = '天蝎座'; // 天蝎座（10月24日～11月22日）
    const sagittarius = '射手座'; // 射手座（11月23日～12月21日）
    const capricorn = '摩羯座'; // 摩羯座（12月22日～1月20日）
    const aquarius = '水瓶座'; // 水瓶座（1月21日～2月19日）
    const pisces = '双鱼座'; // 双鱼座（2月20日～3月20日）

    var constellation = '';

    switch (month) {
      case DateTime.january:
        constellation = day < 21 ? capricorn : aquarius;
        break;
      case DateTime.february:
        constellation = day < 20 ? aquarius : pisces;
        break;
      case DateTime.march:
        constellation = day < 21 ? pisces : aries;
        break;
      case DateTime.april:
        constellation = day < 21 ? aries : taurus;
        break;
      case DateTime.may:
        constellation = day < 22 ? taurus : gemini;
        break;
      case DateTime.june:
        constellation = day < 22 ? gemini : cancer;
        break;
      case DateTime.july:
        constellation = day < 23 ? cancer : leo;
        break;
      case DateTime.august:
        constellation = day < 24 ? leo : virgo;
        break;
      case DateTime.september:
        constellation = day < 24 ? virgo : libra;
        break;
      case DateTime.october:
        constellation = day < 24 ? libra : scorpio;
        break;
      case DateTime.november:
        constellation = day < 23 ? scorpio : sagittarius;
        break;
      case DateTime.december:
        constellation = day < 22 ? sagittarius : capricorn;
        break;
    }
    return constellation;
  }
}
