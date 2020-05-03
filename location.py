import math


class Location:
    """
    Object representation of latitude and longitude in Decimal Degrees format

    Decimal Degrees format:
        (+|-)degree                  where (+) indicates N and E, (-) indicates S and W
        degree° (N|S|E|W)

    Degrees and Decimal Minutes format:
        degree° minute′ (N|S|E|W)

    Degrees Minutes and Seconds format:
        degree° minute′ second″ (N|S|E|W)
        (+|-)degreeº (+|-)minute' (+|-)second'' (N|S|E|W) --> (+|-) depends on directions
    """

    NOTATIONS = {
        'degree': ['\u00b0', '\u00ba'],
        'min': ['\u2032', "'", "`"],
        'sec': ['\u2033', "''"],
        'pos_dir': ['N', 'E'],
        'neg_dir': ['S', 'W']
    }

    def __init__(self, lat_str="", long_str=""):
        self.lat_deg, self.lat_min, self.lat_sec, self.lat_dir = \
            self._extract_format(lat_str)

        self.long_deg, self.long_min, self.long_sec, self.long_dir = \
            self._extract_format(long_str)

    def _extract_format(self, input_format: str):
        """
        Return tuple of degree, minute, second and direction.
        If `input_format` doesn't have some particular value, that value
        will be replace with empty string.
        """
        elements = input_format.split(' ')
        degree, minute, second, direction = '', '', '', ''
        for ele in elements:
            last_char = ele[-1:]
            if last_char in self.NOTATIONS['degree']:
                degree = float(ele[:-1])
            if last_char in self.NOTATIONS['min']:
                try:
                    minute = float(ele[:-1])
                except ValueError:
                    pass
            if last_char in self.NOTATIONS['sec']:
                second = float(ele[:-1])
            elif ele[-2:] in self.NOTATIONS['sec']:
                second = float(ele[:-2])
            if last_char.upper() in self.NOTATIONS['pos_dir'] or last_char.upper() in self.NOTATIONS['neg_dir']:
                direction = last_char.upper()
        return degree, minute, second, direction

    def _convert_to_decimal_degrees(self, deg, min, sec, dir):
        try:
            deg = float(deg)
        except TypeError:
            deg = 0
        try:
            min_deg = min / 60
        except TypeError:
            min_deg = 0
        try:
            sec_deg = sec / 3600
        except TypeError:
            sec_deg = 0

        total_degree = sum([deg, min_deg, sec_deg])
        if dir in self.NOTATIONS['neg_dir']:
            total_degree = abs(total_degree) * -1
        return total_degree

    def get_lat_long(self, dd=True, ddm=False, dms=False):
        """
        Return tuple of latitude and longitude in the format specified
        by key.
        """
        if dd:
            lat = self._convert_to_decimal_degrees(
                self.lat_deg, self.lat_min, self.lat_sec, self.lat_dir
            )
            long = self._convert_to_decimal_degrees(
                self.long_deg, self.long_min, self.long_sec, self.long_dir
            )
            return round(lat, 6), round(long, 6)

    def __str__(self):
        lat = [self.lat_deg, self.lat_min, self.lat_sec, self.lat_dir]
        lat = [str(x) for x in lat if x != ""]
        lat_str = " ".join(lat)
        long = [self.long_deg, self.long_min, self.long_sec, self.long_dir]
        long = [str(x) for x in long if x != ""]
        long_str = " ".join(long)
        return f'{lat_str} / {long_str}'


if __name__ == '__main__':
    # check at: https://www.pgc.umn.edu/apps/convert/
    # test cases
    l2 = Location("-14º -15' -59'' S", "-170º -40' -59'' W")
    l3 = Location("40° 26.767′ N", "40° 26.767′ W")
    l4 = Location("40.446° N", "40.446° W")
    l5 = Location("40° 26′ 46″ N", "40° 26′ 46″ E")
    print(l2)
    print(l2.get_lat_long())
    print("--------------------")
    print(l4)
    print(l4.get_lat_long())

