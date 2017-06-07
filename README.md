# 数电项目 单周期非流水线CPU
[TOC]
## 文件命名
1. 除了`head.v`外，其余文件用全大写加下划线方式命名

## 代码风格
1. 全局常量使用宏定义，定义在文件`head.v`内
2. 文件内常量定义在相应文件内
3. 文件的第一个注释通常是文件大致解释和模块使用的注意事项（潜在bug）

## 文件
### Register
- REGESTER_FILE.v
    1. 定义了常量0-15代表15个寄存器和特殊的无寄存器
    2. 定义了一组指令集的指令头的代号
- REGISTER_FILE_HELPER.v
    1. 定义了`srcA`,`srcB`,`destE`,`destM`等辅助模块
- REGISTER_FILE_tb.v
    1. 测试文件（测试通过）    

### AlgorithmLogicUnit
- ALU.v
	1. 定义了算术逻辑单元
- ALU_tb.v
	1. 测试文件（未完成外围模块）

### header

### Instrument

### Memory

### Other

### Program Counter

## WARNING:
1. 条件码应修改为锁存器
2. 汇编器和取指器的分工应完善

