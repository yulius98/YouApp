/// Utility class for astrology-related calculations and zodiac signs
class AstrologyUtils {
  /// zodiac 
  static const List<Map<String, dynamic>> _zodiacRanges = [
    {'start': '2023-01-22', 'end': '2024-02-09', 'sign': 'Rabbit'},
    {'start': '2022-02-01', 'end': '2023-01-21', 'sign': 'Tiger'},
    {'start': '2021-02-12', 'end': '2022-01-31', 'sign': 'Ox'},
    {'start': '2020-01-25', 'end': '2021-02-11', 'sign': 'Rat'},
    {'start': '2019-02-05', 'end': '2020-01-24', 'sign': 'Pig'},
    {'start': '2018-02-16', 'end': '2019-02-04', 'sign': 'Dog'},
    {'start': '2017-01-28', 'end': '2018-02-15', 'sign': 'Rooster'},
    {'start': '2016-02-08', 'end': '2017-01-27', 'sign': 'Monkey'},
    {'start': '2015-02-19', 'end': '2016-02-07', 'sign': 'Goat'},
    {'start': '2014-01-31', 'end': '2015-02-18', 'sign': 'Horse'},
    {'start': '2013-02-10', 'end': '2014-01-30', 'sign': 'Snake'},
    {'start': '2012-01-23', 'end': '2013-02-09', 'sign': 'Dragon'},
    {'start': '2011-02-03', 'end': '2012-01-22', 'sign': 'Rabbit'},
    {'start': '2010-02-14', 'end': '2011-02-02', 'sign': 'Tiger'},
    {'start': '2009-01-26', 'end': '2010-02-13', 'sign': 'Ox'},
    {'start': '2008-02-07', 'end': '2009-01-25', 'sign': 'Rat'},
    {'start': '2007-02-18', 'end': '2008-02-06', 'sign': 'Boar'},
    {'start': '2006-01-29', 'end': '2007-02-17', 'sign': 'Dog'},
    {'start': '2005-02-09', 'end': '2006-01-28', 'sign': 'Rooster'},
    {'start': '2004-01-22', 'end': '2005-02-08', 'sign': 'Monkey'},
    {'start': '2003-02-01', 'end': '2004-01-21', 'sign': 'Goat'},
    {'start': '2002-02-12', 'end': '2003-01-31', 'sign': 'Horse'},
    {'start': '2001-01-24', 'end': '2002-02-11', 'sign': 'Snake'},
    {'start': '2000-02-05', 'end': '2001-01-23', 'sign': 'Dragon'},
    {'start': '1999-02-16', 'end': '2000-02-04', 'sign': 'Rabbit'},
    {'start': '1998-01-28', 'end': '1999-02-15', 'sign': 'Tiger'},
    {'start': '1997-02-07', 'end': '1998-01-27', 'sign': 'Ox'},
    {'start': '1996-02-19', 'end': '1997-02-06', 'sign': 'Rat'},
    {'start': '1995-01-31', 'end': '1996-02-18', 'sign': 'Boar'},
    {'start': '1994-02-10', 'end': '1995-01-30', 'sign': 'Dog'},
    {'start': '1993-01-23', 'end': '1994-02-09', 'sign': 'Rooster'},
    {'start': '1992-02-04', 'end': '1993-01-22', 'sign': 'Monkey'},
    {'start': '1991-02-15', 'end': '1992-02-03', 'sign': 'Goat'},
    {'start': '1990-01-27', 'end': '1991-02-14', 'sign': 'Horse'},
    {'start': '1989-02-06', 'end': '1990-01-26', 'sign': 'Snake'},
    {'start': '1988-02-17', 'end': '1989-02-05', 'sign': 'Dragon'},
    {'start': '1987-01-29', 'end': '1988-02-16', 'sign': 'Rabbit'},
    {'start': '1986-02-09', 'end': '1987-01-28', 'sign': 'Tiger'},
    {'start': '1985-02-20', 'end': '1986-02-08', 'sign': 'Ox'},
    {'start': '1984-02-02', 'end': '1985-02-19', 'sign': 'Rat'},
    {'start': '1983-02-13', 'end': '1984-02-01', 'sign': 'Boar'},
    {'start': '1982-01-25', 'end': '1983-02-12', 'sign': 'Dog'},
    {'start': '1981-02-05', 'end': '1982-01-24', 'sign': 'Rooster'},
    {'start': '1980-02-16', 'end': '1981-02-04', 'sign': 'Monkey'},
    {'start': '1979-01-28', 'end': '1980-02-15', 'sign': 'Goat'},
    {'start': '1978-02-07', 'end': '1979-01-27', 'sign': 'Horse'},
    {'start': '1977-02-18', 'end': '1978-02-06', 'sign': 'Snake'},
    {'start': '1976-01-31', 'end': '1977-02-17', 'sign': 'Dragon'},
    {'start': '1975-02-11', 'end': '1976-01-30', 'sign': 'Rabbit'},
    {'start': '1974-01-23', 'end': '1975-02-10', 'sign': 'Tiger'},
    {'start': '1973-02-03', 'end': '1974-01-22', 'sign': 'Ox'},
    {'start': '1972-01-16', 'end': '1973-02-02', 'sign': 'Rat'},
    {'start': '1971-01-27', 'end': '1972-01-15', 'sign': 'Boar'},
    {'start': '1970-02-06', 'end': '1971-01-26', 'sign': 'Dog'},
    {'start': '1969-02-17', 'end': '1970-02-05', 'sign': 'Rooster'},
    {'start': '1968-01-30', 'end': '1969-02-16', 'sign': 'Monkey'},
    {'start': '1967-02-09', 'end': '1968-01-29', 'sign': 'Goat'},
    {'start': '1966-01-21', 'end': '1967-02-08', 'sign': 'Horse'},
    {'start': '1965-02-02', 'end': '1966-01-20', 'sign': 'Snake'},
    {'start': '1964-02-13', 'end': '1965-02-01', 'sign': 'Dragon'},
    {'start': '1963-01-25', 'end': '1964-02-12', 'sign': 'Rabbit'},
    {'start': '1962-02-05', 'end': '1963-01-24', 'sign': 'Tiger'},
    {'start': '1961-02-15', 'end': '1962-02-04', 'sign': 'Ox'},
    {'start': '1960-01-28', 'end': '1961-02-14', 'sign': 'Rat'},
    {'start': '1959-02-08', 'end': '1960-01-27', 'sign': 'Boar'},
    {'start': '1958-02-18', 'end': '1959-02-07', 'sign': 'Dog'},
    {'start': '1957-01-31', 'end': '1958-02-17', 'sign': 'Rooster'},
    {'start': '1956-02-12', 'end': '1957-01-30', 'sign': 'Monkey'},
    {'start': '1955-01-24', 'end': '1956-02-11', 'sign': 'Goat'},
    {'start': '1954-02-03', 'end': '1955-01-23', 'sign': 'Horse'},
    {'start': '1953-02-14', 'end': '1954-02-02', 'sign': 'Snake'},
    {'start': '1952-01-27', 'end': '1953-02-13', 'sign': 'Dragon'},
    {'start': '1951-02-06', 'end': '1952-01-26', 'sign': 'Rabbit'},
    {'start': '1950-02-17', 'end': '1951-02-05', 'sign': 'Tiger'},
    {'start': '1949-01-29', 'end': '1950-02-16', 'sign': 'Ox'},
    {'start': '1948-02-10', 'end': '1949-01-28', 'sign': 'Rat'},
    {'start': '1947-01-22', 'end': '1948-02-09', 'sign': 'Boar'},
    {'start': '1946-02-02', 'end': '1947-01-21', 'sign': 'Dog'},
    {'start': '1945-02-13', 'end': '1946-02-01', 'sign': 'Rooster'},
    {'start': '1944-01-25', 'end': '1945-02-12', 'sign': 'Monkey'},
    {'start': '1943-02-05', 'end': '1944-01-24', 'sign': 'Goat'},
    {'start': '1942-02-15', 'end': '1943-02-04', 'sign': 'Horse'},
    {'start': '1941-01-27', 'end': '1942-02-14', 'sign': 'Snake'},
    {'start': '1940-02-08', 'end': '1941-01-26', 'sign': 'Dragon'},
    {'start': '1939-02-19', 'end': '1940-02-07', 'sign': 'Rabbit'},
    {'start': '1938-01-31', 'end': '1939-02-18', 'sign': 'Tiger'},
    {'start': '1937-02-11', 'end': '1938-01-30', 'sign': 'Ox'},
    {'start': '1936-01-24', 'end': '1937-02-10', 'sign': 'Rat'},
    {'start': '1935-02-04', 'end': '1936-01-23', 'sign': 'Boar'},
    {'start': '1934-02-14', 'end': '1935-02-03', 'sign': 'Dog'},
    {'start': '1933-01-26', 'end': '1934-02-13', 'sign': 'Rooster'},
    {'start': '1932-02-06', 'end': '1933-01-25', 'sign': 'Monkey'},
    {'start': '1931-02-17', 'end': '1932-02-05', 'sign': 'Goat'},
    {'start': '1930-01-30', 'end': '1931-02-16', 'sign': 'Horse'},
    {'start': '1929-02-10', 'end': '1930-01-29', 'sign': 'Snake'},
    {'start': '1928-01-23', 'end': '1929-02-09', 'sign': 'Dragon'},
    {'start': '1927-02-02', 'end': '1928-01-22', 'sign': 'Rabbit'},
    {'start': '1926-02-13', 'end': '1927-02-01', 'sign': 'Tiger'},
    {'start': '1925-01-25', 'end': '1926-02-12', 'sign': 'Ox'},
    {'start': '1924-02-05', 'end': '1925-01-24', 'sign': 'Rat'},
    {'start': '1923-02-16', 'end': '1924-02-04', 'sign': 'Boar'},
    {'start': '1922-01-28', 'end': '1923-02-15', 'sign': 'Dog'},
    {'start': '1921-02-08', 'end': '1922-01-27', 'sign': 'Rooster'},
    {'start': '1920-02-20', 'end': '1921-02-07', 'sign': 'Monkey'},
    {'start': '1919-02-01', 'end': '1920-02-19', 'sign': 'Goat'},
    {'start': '1918-02-11', 'end': '1919-01-31', 'sign': 'Horse'},
    {'start': '1917-01-23', 'end': '1918-02-10', 'sign': 'Snake'},
    {'start': '1916-02-03', 'end': '1917-01-22', 'sign': 'Dragon'},
    {'start': '1915-02-14', 'end': '1916-02-02', 'sign': 'Rabbit'},
    {'start': '1914-01-26', 'end': '1915-02-13', 'sign': 'Tiger'},
    {'start': '1913-02-06', 'end': '1914-01-25', 'sign': 'Ox'},
    {'start': '1912-02-18', 'end': '1913-02-05', 'sign': 'Rat'},
  ];

  /// Gets Chinese zodiac sign based on birth date
  static String getZodiac(DateTime? date) {
    if (date == null) return '--';

    for (final range in _zodiacRanges) {
      final start = DateTime.parse(range['start']);
      final end = DateTime.parse(range['end']);

      if (date.isAfter(start.subtract(const Duration(days: 1))) &&
          date.isBefore(end.add(const Duration(days: 1)))) {
        return range['sign'];
      }
    }
    return '--';
  }

  /// horoscope 
  static String getHoroscope(DateTime date) {
    final month = date.month;
    final day = date.day;

    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) return 'Aries';
    if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) return 'Taurus';
    if ((month == 5 && day >= 21) || (month == 6 && day <= 21)) return 'Gemini';
    if ((month == 6 && day >= 22) || (month == 7 && day <= 22)) return 'Cancer';
    if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) return 'Leo';
    if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) return 'Virgo';
    if ((month == 9 && day >= 23) || (month == 10 && day <= 23)) return 'Libra';
    if ((month == 10 && day >= 24) || (month == 11 && day <= 21)) return 'Scorpius';
    if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) return 'Sagittarius';
    if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) return 'Capricornus';
    if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) return 'Aquarius';
    if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) return 'Pisces';

    return '--';
  }
}