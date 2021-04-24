import requests

cookies = {
    'ICITYSession': 'eacf10256e604e60833c560d71db7283',
}

headers = {
    'Connection': 'keep-alive',
    'Accept': 'application/json, text/javascript, */*; q=0.01',
    'X-Requested-With': 'XMLHttpRequest',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36',
    'Content-Type': 'application/json',
    'Origin': 'http://lf.sxzwfw.gov.cn',
    'Referer': 'http://lf.sxzwfw.gov.cn/icity/govservice/project?i=1&type=gr',
    'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7',
}

params = (
    ('s', 'b123981617245747741'),
    ('t', '3753_b51239_1617245675000'),
)

data = '{"page":"1","limit":5,"regionCode":"141000","orgCode":"","type":"","title":"","serviceObject":"person","titleName":"","online":"","SearchName":""}'

response = requests.post('http://lf.sxzwfw.gov.cn/icity/api-v2/app.icity.govservice.PersonalServiceCmd/getItemAndTaskByPage', headers=headers, params=params, cookies=cookies, data=data, verify=False)
print("jsdu", response.json())
#NB. Original query string below. It seems impossible to parse and
#reproduce query strings 100% accurately so the one below is given
#in case the reproduced version is not "correct".
# response = requests.post('http://lf.sxzwfw.gov.cn/icity/api-v2/app.icity.govservice.PersonalServiceCmd/getItemAndTaskByPage?s=b123981617245747741&t=3753_b51239_1617245675000', headers=headers, cookies=cookies, data=data, verify=False)
