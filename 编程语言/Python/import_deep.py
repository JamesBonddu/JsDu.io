import sys
import eventlet
from inspect import isclass
from pkgutil import iter_modules
from pathlib import Path
from importlib import import_module

eventlet.monkey_patch(os=None, select=None)

import pkgutil
from pprint import pprint
import ipdb; ipdb.set_trace()
import sys
print('jsdu.__path__ before:')
pprint.pprint(__path__)

__path__ = pkgutil.extend_path(__path__, __name__)


# iterate through the modules in the current package
package_dir = Path(__file__).resolve().parent
for (_, module_name, is_module) in iter_modules([package_dir]):
    # if is_module:
    # import the module and iterate through its attributes
    module = import_module(f"{__name__}.{module_name}")
    for attribute_name in dir(module):
        attribute = getattr(module, attribute_name)

        if isclass(attribute):
            # Add the class to this package's variables
            globals()[attribute_name] = attribute


class Watcher(object):
    @classmethod
    def find_module(cls, name, path, target=None):
        print("Importing", name, path, target)
        return None


sys.meta_path.insert(0, Watcher)

from .run import create_app     # noqa: E402


__version__ = '0.1.0'

app = create_app()


__all__ = ['__version__']
