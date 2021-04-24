#  sentry


## 自動導入

```python
def import_submodules(context, root_module, path):
    """
    Import all submodules and register them in the ``context`` namespace.
    >>> import_submodules(locals(), __name__, __path__)
    """
    for loader, module_name, is_pkg in pkgutil.walk_packages(path, root_module + "."):
        # this causes a Runtime error with model conflicts
        # module = loader.find_module(module_name).load_module(module_name)
        module = __import__(module_name, globals(), locals(), ["__name__"])
        for k, v in six.iteritems(vars(module)):
            if not k.startswith("_"):
                context[k] = v
        context[module_name] = module
```

## DEBUG時的关键函数

```python
from __future__ import absolute_import

from time import time


class FunctionWrapper(object):
    def __init__(self, collector):
        self.collector = collector

    def __call__(self, func, *args, **kwargs):
        __traceback_hide__ = True  # NOQA

        start = time()
        try:
            return func(*args, **kwargs)
        finally:
            end = time()

            if getattr(func, "im_class", None):
                arg_str = repr(args[1:])
            else:
                arg_str = repr(args)

            data = {
                "name": func.__name__,
                "args": arg_str,
                "kwargs": repr(kwargs),
                "start": start,
                "end": end,
            }
            self.record(data)

    def record(self, data):
        self.collector.append(data)


from __future__ import absolute_import

import threading
import weakref


class ThreadCollector(object):
    def __init__(self):
        self.collections = weakref.WeakKeyDictionary()

    def enable(self, thread=None):
        if thread is None:
            thread = threading.currentThread()
        self.collections[thread] = []
        return self.collections[thread]

    def disable(self, thread=None):
        if thread is None:
            thread = threading.currentThread()
        try:
            del self.collections[thread]
        except KeyError:
            pass

    def get(self, thread=None):
        if thread is None:
            thread = threading.currentThread()
        return self.collections[thread]

    def append(self, item, thread=None):
        if thread is None:
            thread = threading.currentThread()
        # fail silently if not active for thread
        if thread not in self.collections:
            return
        self.collections[thread].append(item)
```