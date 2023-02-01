import re

strs = '#JSSSdu&666#sd'
low_case_callback = lambda pat: pat.group(0).lower()
strs = re.sub(r'([A-Z])', low_case_callback, strs)
print("low_case_callback", strs)

pad_case_callback = lambda pat: '0'
strs = re.sub(r'\d', pad_case_callback, strs)
print("pad_case_callback", strs)

match_pattern = re.compile(r"[a-z0-9_-]+")
result = match_pattern.findall(strs)
print("".join(result))
