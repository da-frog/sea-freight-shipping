from math import radians, cos, sin, asin, sqrt


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

    def __init__(self, lat_str, long_str):
        assert lat_str != ''
        assert long_str != ''
        self.lat_deg, self.lat_min, self.lat_sec, self.lat_dir = x = \
            self._extract_format(lat_str)
        # print(f'{x=}')
        # print(f'{self.lat_deg=}')

        self.long_deg, self.long_min, self.long_sec, self.long_dir = \
            self._extract_format(long_str)

    def _extract_format(self, input_format: str):
        """
        Return tuple of degree, minute, second and direction.
        If `input_format` doesn't have some particular value, that value
        will be replace with empty string.
        """
        elements = input_format.split(' ')
        minute, second, direction = '', '', ''
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
        try:
            # print(f'{input_format=} {degree=} {minute=} {second=} {direction=}')
            return degree, minute, second, direction
        except UnboundLocalError:
            degree = float(input_format)
            return degree, 0, 0, ''

    def _convert_to_decimal_degrees(self, deg, min, sec, dir):
        try:
            deg = float(deg)
        except TypeError:
            deg = 0
        # except ValueError:
        #     print(f'{deg=}')
        #     raise
        try:
            min_deg = min / 60
        except TypeError:
            min_deg = 0
        # except ValueError:
        #     deg = 0
        try:
            sec_deg = sec / 3600
        except TypeError:
            sec_deg = 0
        # except ValueError:
        #     deg = 0

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
            # print(f'{self.lat_deg=}')
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

    def calculate_distance(self, other):
        # get lat, long in decimal degree format
        lat1, lon1 = self.get_lat_long(dd=True)
        lat2, lon2 = other.get_lat_long(dd=True)
        return calculate_distance(lat1, lon1, lat2, lon2)


def calculate_distance(lat1, lon1, lat2, lon2):
    # The math module contains a function named
    # radians which converts from degrees to radians.
    lon1 = radians(lon1)
    lon2 = radians(lon2)
    lat1 = radians(lat1)
    lat2 = radians(lat2)

    # Haversine formula
    dlon = lon2 - lon1
    dlat = lat2 - lat1
    a = sin(dlat / 2) ** 2 + cos(lat1) * cos(lat2) * sin(dlon / 2) ** 2

    c = 2 * asin(sqrt(a))

    # Radius of earth in kilometers. Use 3956 for miles
    r = 6371

    # calculate the result
    return c * r


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
    print("--------------------")
    print(f"distance between l2 and l4 = {l2.calculate_distance(l3)}")


