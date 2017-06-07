def bit2hex(b):
    if (b <= 9):
        return str(b)
    else:
        return chr(ord("A") + b - 10)

def num2hex(n):
    tmp = []
    n = int(n)
    if (n < 0):
        n += 2 ** 64
    for i in range(16):
        tmp.insert(0, n % 16)
        n //= 16
    ret = ""
    for i in range(0, 16, 2):
        #print('test: {} {}'.format(tmp[i] , tmp[i + 1]))
        ret = bit2hex(tmp[i]) + bit2hex(tmp[i + 1]) + " " + ret
    return ret

print(num2hex(16))
