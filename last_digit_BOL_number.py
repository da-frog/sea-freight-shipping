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

