def iso_code_to_length_and_height(iso_code: str):
    assert len(iso_code) == 4
    length = {
        '1': 10,
        '2': 20,
        '3': 30,
        '4': 40,
        'B': 24,
        'C': 24.5,
        'G': 41,
        'H': 43,
        'L': 45,
        'M': 48,
        'N': 49,
    }[iso_code[0].upper()]
    height = {
        '0': 8,
        '2': 8.5,
        '4': 9,
        '5': 9.5,
        '6': 9.5,
        '8': 4.25,  # >
        '9': 4,
        'C': 8.5,
        'D': 9,     # <=
        'E': 9.5,
        'F': 9.5,   # >
    }[iso_code[1].upper()]
    width = {
        '0': 8,
        '2': 8,
        '4': 8,
        '5': 8,
        '6': 8,
        '8': 8,
        '9': None,
        'C': 8.16,  # 8 ft (2,438 mm) < x ≤ 8 ft 2 in
        'D': 8.16,  # 8 ft (2,438 mm) < x ≤ 8 ft 2 in
        'E': 8.16,  # 8 ft (2,438 mm) < x ≤ 8 ft 2 in
        'F': 8.16,  # 8 ft (2,438 mm) < x ≤ 8 ft 2 in
    }[iso_code[1].upper()]
    return length, width, height
