import random


def get_bol_check_digit(bol_num: str) -> str:
    # Step 1 sum all even index num multiply by 3
    sum_even_mul3 = 0
    for even_index in range(1, 16, 2):
        sum_even_mul3 += int(bol_num[even_index])
    sum_even_mul3 *= 3
    # Step 2 sum all odd index
    sum_odd = 0
    for odd_index in range(0, 15, 2):
        sum_odd += int(bol_num[odd_index])
    # Step 3 get last digit, find the number which round last digit to 0 Ex. 2 + 8 = 1 [0]
    last_dig = int(str(sum_even_mul3 + sum_odd)[-1])
    if not last_dig:
        return str(last_dig)
    return str(10 - last_dig)


def random_bol(year: int):
    if year > 2020:
        raise AssertionError('The future is not known!')
    if year == 2020:
        stats = [
            (0.1791044776, 'EXW'),
            (0.2189054726, 'FCA'),
            (0.2487562189, 'CPT'),
            (0.2885572139, 'CIP'),
            (0.3084577114, 'DPU'),
            (0.3980099502, 'DAP'),
            (0.4029850746, 'DDP'),
            (0.4328358209, 'FAS'),
            (0.5820895522, 'FOB'),
            (0.7213930348, 'CFR'),
            (1, 'CIF')
        ]
    elif year >= 2010:
        stats = [
            (0.1791044776, 'EXW'),
            (0.2189054726, 'FCA'),
            (0.2487562189, 'CPT'),
            (0.2885572139, 'CIP'),
            (0.3084577114, 'DAT'),
            (0.3980099502, 'DAP'),
            (0.4029850746, 'DDP'),
            (0.4328358209, 'FAS'),
            (0.5820895522, 'FOB'),
            (0.7213930348, 'CFR'),
            (1, 'CIF')
        ]
    elif year >= 2000:
        stats = [
            (0.1628959276, 'EXW'),
            (0.2081447964, 'FCA'),
            (0.2352941176, 'CPT'),
            (0.2805429864, 'CIP'),
            (0.3167420814, 'DDP'),
            (0.3484162896, 'FAS'),
            (0.4841628959, 'FOB'),
            (0.6244343891, 'CFR'),
            (0.8823529412, 'CIF'),
            (0.9321266968, 'DDU'),
            (0.9547511312, 'DEQ'),
            (0.9773755656, 'DES'),
            (1, 'DAF')
        ]
    else:
        raise AssertionError('Too long ago!')

    r = random.random()
    for cut_off, term in stats:
        if r <= cut_off:
            return term
