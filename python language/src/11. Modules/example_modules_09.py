# example_modules_09.py

import tools
from example_modules_08 import spam


foo = spam(3, 4, tools.add)
bar = spam(5, 6, tools.mul)
baz = spam(7, -8, tools.add_abs)

print(f"{foo=}")
print(f"{bar=}")
print(f"{baz=}")
