#!/usr/bin/env python3
# -*- coding: utf-8 -*-
__author__ = 'zhou shugaung'

import pyperclip
import re





# print("请输入要漂白的文字")
# argus = input()
# print("当前输入的是", argus)


currentwords = pyperclip.paste()


import re

pattern = '(?<=\S)\n(?=\S)'
repl = ''

# result = currentwords.replace(pattern, repl)


result = re.sub(pattern, repl, currentwords)

result = result.replace(',', '，')

result = result.replace('.', '。')

print(result)

pyperclip.copy(result)

input("请输入任意键结束")

# # 删除空格
# word = ''.join([i.strip(' ') for i in content])




# print(word)
