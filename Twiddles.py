import math

WIDTH = 32
is_real = True


def fractional_to_mantissa_binary(num, width):
    if num == 1.0:
        return '1' * width

    binary_rep = ''

    fractional_part = abs(num)
    for _ in range(width):
        fractional_part *= 2
        bit = int(fractional_part)
        binary_rep += str(bit)
        fractional_part -= bit

    return binary_rep


def twos_complement(binary_str):

    is_negative = binary_str[0] == '1'
    result = ""
    carry = 1 if is_negative else 0

    for bit in binary_str[::-1]:
        if bit == '0':
            result = '1' + result if carry else '0' + result
        else:
            result = '0' + result if carry else '1' + result

    if carry:
        result = '1' + result

    return result


def obtain_hex_int(k):
    a = math.pi * 2 * k / WIDTH

    if is_real:
        b = math.cos(a)
    else:
        b = math.sin(a)

    is_negative = b < 0

    if is_negative:
        mantissas = fractional_to_mantissa_binary(-b, (WIDTH // 2) - 1)
        inverted_mantissas = ''.join(['1' if bit == '0' else '0' for bit in mantissas])
        carry = 1
        twos_complement_mantissas = ''
        for bit in inverted_mantissas[::-1]:
            if bit == '0':
                twos_complement_mantissas = '1' + twos_complement_mantissas if carry else '0' + twos_complement_mantissas
            else:
                twos_complement_mantissas = '0' + twos_complement_mantissas if carry else '1' + twos_complement_mantissas
            carry = carry and (bit == '1')

    else:
        mantissas = fractional_to_mantissa_binary(b, (WIDTH // 2) - 1)

    if is_negative:
        mantissas = '1' + twos_complement_mantissas
    else:
        mantissas = '0' + mantissas

    return hex(int(mantissas, 2))


stringOne = str(WIDTH//2) + "'h"

for i in range(WIDTH//2):
    stringTwo = str(i) + ": twiddle_out <= " + stringOne + obtain_hex_int(i)[2:] + ";"
    print(stringTwo)
    print()