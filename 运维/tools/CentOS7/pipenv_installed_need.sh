pip_install_need() {
python3 - << EOF
#!/usr/bin/python
import json
import os
with open("./Pipfile.lock", 'rb') as f:
    pkg_json = json.load(f)
    pkg_set = set(p.lower() for p in pkg_json.get('default').keys())
    pkg_set = pkg_set.union(set(p.lower() for p in pkg_json.get('develop').keys()))
    print(pkg_set)

    installed_list = []
    installed_pkg_str = os.popen('cd "YOUR PIPENV PROJECT NAME" &&. $(pipenv --venv)/bin/activate && pip list').read()
    installed_pkg_arr = installed_pkg_str.split('\n')[2:]
    for installed_pkg in installed_pkg_arr:
        installed = installed_pkg.split(' ')[0]
        installed_list.append(installed.lower())
    print(installed_list)
    for pkg in pkg_set:
        if pkg not in installed_list:
            print('pip install {}'.format(pkg))
            os.popen('pipenv install {}'.format(pkg))
        else:
            print('{} is installed'.format(pkg))
EOF
}
