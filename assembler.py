from re import *
import sys
info = '''
assembler
    usage: python3 assembler.py <input-filename> [output-filename] [-b] [-h]
    -b : output in the form of binary code
    -h (default) : output in the form of hexadecimal code
'''
if len(sys.argv) == 1:
    print(info)
    quit()
elif len(sys.argv) == 2:
    input_filename = sys.argv[1]
    output_filename = "a.s"
else:
    input_filename = sys.argv[1]
    output_filename = sys.argv[2]

register = {"%rax":0, "%rcx":1, "%rdx":2, "%rbx":3, "%rsp":4, "%rbp":5, "%rsi":6, "%rdi":7, "%r8": 8, "%r9": 9, "%r10": 10, "%r11": 11, "%r12": 12, "%r13": 13, "%r14": 14}
# following 2 function uesd to convert number to 64bit hex
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

def print_error(line_num, msg):
    print("line {} ERROR: {}".format(str(line_num), msg))

def print_warning(line_num, msg):
    print("line {} WARNING: {}".format(str(line_num), msg))

# match register
r_reg = "(%rax|%rcx|%rdx|%rbx|%rsp|%rbp|%rsi|%rdi|%r8|%r9|%r10|%r11|%r12|%r13|%r14)"
# match register, register
r_reg_reg = r"({},\s?{})".format(r_reg, r_reg)
# ins for instant number
# none for none-register
# valreg for $(120)%rax like this
# val for instant number like $(120)
r_ins = r"(\$\(-?\d+\))"
r_ins_reg = r"({},\s?{})".format(r_ins, r_reg)
r_valreg = "({}{})".format(r_ins, r_reg)
r_order_none = "(halt|nop|ret)"
r_order_reg_reg = "(rrmovq|cmovle|cmovl|cmove|cmovne|cmovge|cmovg|addq|subq|andq|xorq)"
r_order_reg_valreg = "(rmmovq)"
r_order_valreg_reg = "(mrmovq)"
r_order_val = "(jmp|jle|jl|je|jne|jge|jg|call)"
r_order_val_reg = "(irmovq)"
r_order_reg = "(pushq|popq)"

regex_instru_none = "({}$)".format(r_order_none)
regex_instru_reg_reg = "({}\s{}$)".format(r_order_reg_reg, r_reg_reg)
regex_instru_reg_valreg = "({}\s{},\s?{}$)".format(r_order_reg_valreg, r_reg, r_valreg)
regex_instru_valreg_reg = "({}\s{},\s?{}$)".format(r_order_valreg_reg, r_valreg, r_reg)
regex_instru_val = "({}\s{}$)".format(r_order_val, r_ins)
regex_instru_val_reg = "({}\s{},\s?{}$)".format(r_order_val_reg, r_ins, r_reg)
regex_instru_reg = "({}\s{}$)".format(r_order_reg, r_reg)

regex_instrument = "({}|{}|{}|{}|{}|{}|{})".format(regex_instru_none, regex_instru_reg_reg, regex_instru_reg_valreg, regex_instru_valreg_reg, regex_instru_val, regex_instru_val_reg, regex_instru_reg)

f = open(input_filename, "r")
input_data = f.read()
data_line = input_data.split("\n")
line_num = 0
#print(data_line)
error_msgs = ""
output_data = ""
for instru in data_line:
    line_num += 1
    ret = instru
    if (instru == ""):
        continue

    print("{:<2} {:<30}".format(line_num, instru), end = ' ')
    if (match(regex_instru_reg_valreg, instru)):
        m = match(regex_instru_reg_valreg, instru)
        ret = "40 "
        ret += bit2hex(register[m.groups()[2]])
        ret += bit2hex(register[m.groups()[-1]])
        ret += " "
        ret += num2hex(m.groups()[-2][2:-1])
        #print(m.groups())
    #WARNING: rB is before rA!
    elif(match(regex_instru_valreg_reg, instru)):
        m = match(regex_instru_valreg_reg, instru)
        ret = "50 "
        #print(m.groups())
        ret += bit2hex(register[m.groups()[-1]])
        ret += bit2hex(register[m.groups()[-2]])
        ret += " "
        ret += num2hex(m.groups()[-3][2:-1])
    # general cases
        
    elif (match(regex_instru_val_reg, instru)):
        m = match(regex_instru_val_reg, instru)
        ret = "30 F"
        ret += bit2hex(register[m.groups()[-1]]) + " "
        ret += num2hex(m.groups()[-2][2:-1])
        #print(m.groups())

    elif (match(regex_instrument, instru)):
        ret = sub("halt", "00", ret)
        ret = sub("nop", "10", ret)
        ret = sub("rrmovq", "20", ret)

        ret = sub("addq", "60", ret)
        ret = sub("subq", "61", ret)
        ret = sub("andq", "62", ret)
        ret = sub("xorq", "63", ret)
        ret = sub("call", "80", ret)
        ret = sub("ret", "90", ret)
        ret = sub("pushq", "A0", ret)
        ret = sub("popq", "B0", ret)
        
        ret = sub("jmp", "70", ret)
        ret = sub("jle", "71", ret)
        ret = sub("jl", "72", ret)
        ret = sub("je", "73", ret)
        ret = sub("jne", "74", ret)
        ret = sub("jge", "75", ret)
        ret = sub("jg", "76", ret)

        ret = sub("cmovle", "21", ret)
        ret = sub("cmovl", "22", ret)
        ret = sub("cmove", "23", ret)
        ret = sub("cmovne", "24", ret)
        ret = sub("cmovge", "25", ret)
        ret = sub("cmovg", "26", ret)

        #for register
        ret = sub("%rax(,)?(\s)?", "0", ret)
        ret = sub("%rcx(,)?(\s)?", "1", ret)
        ret = sub("%rdx(,)?(\s)?", "2", ret)
        ret = sub("%rbx(,)?\ ?", "3", ret)
        ret = sub("%rsp(,)?(\s)?", "4", ret)
        ret = sub("%rbp(,)?(\s)?", "5", ret)
        ret = sub("%rsi(,)?(\s)?", "6", ret)
        ret = sub("%rdi(,)?(\s)?", "7", ret)
        ret = sub("%r8(,)?(\s)?", "8", ret)
        ret = sub("%r9(,)?(\s)?", "9", ret)
        ret = sub("%r10(,)?(\s)?", "A", ret)
        ret = sub("%r11(,)?(\s)?", "B", ret)
        ret = sub("%r12(,)?(\s)?", "C", ret)
        ret = sub("%r13(,)?(\s)?", "D", ret)
        ret = sub("%r14(,)?(\s)?", "E", ret)

        #used to change number like $(120)
        m = search(r_ins, ret)
        if (m):
            ret = sub(",\s", "", ret)
            ret = sub(r_ins, num2hex(m.group()[2:-1]), ret)

        if (match(regex_instru_reg, instru)):
            ret += "F"
    else:
        msg = "invalid syntax"
        error_msgs += "line {} ERROR: {}\n".format(str(line_num), msg)
    if (ret != instru):
        print(ret)
        output_data += ret + '\n'
    else:
        print("-" * 29)

print()
if (error_msgs != ""):
    print(error_msgs)
else:
    fout = open(output_filename, "w")
    if ("-b" in sys.argv):
        output_data = sub("0", "0000", output_data)
        output_data = sub("1", "0001", output_data)
        output_data = sub("2", "0010", output_data)
        output_data = sub("3", "0011", output_data)
        output_data = sub("4", "0100", output_data)
        output_data = sub("5", "0101", output_data)
        output_data = sub("6", "0110", output_data)
        output_data = sub("7", "0111", output_data)
        output_data = sub("8", "1000", output_data)
        output_data = sub("9", "1001", output_data)
        output_data = sub("A", "1010", output_data)
        output_data = sub("B", "1011", output_data)
        output_data = sub("C", "1100", output_data)
        output_data = sub("D", "1101", output_data)
        output_data = sub("E", "1110", output_data)
        output_data = sub("F", "1111", output_data)

    fout.write(output_data)
#fout = open("a.s", "w")
#fout.write(input_data)
