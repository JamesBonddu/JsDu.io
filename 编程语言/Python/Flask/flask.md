# Flask


## Flask 自動注冊

```python
def auto_find_instance_path(self):
    """Tries to locate the instance path if it was not provided to the
    constructor of the application class.  It will basically calculate
    the path to a folder named ``instance`` next to your main file or
    the package.

    .. versionadded:: 0.8
    """
    prefix, package_path = find_package(self.import_name)
    if prefix is None:
        return os.path.join(package_path, "instance")
    return os.path.join(prefix, "var", f"{self.name}-instance")


def find_package(import_name):
    """Finds a package and returns the prefix (or None if the package is
    not installed) as well as the folder that contains the package or
    module as a tuple.  The package path returned is the module that would
    have to be added to the pythonpath in order to make it possible to
    import the module.  The prefix is the path below which a UNIX like
    folder structure exists (lib, share etc.).
    """
    root_mod_name, _, _ = import_name.partition(".")
    package_path = _find_package_path(root_mod_name)
    site_parent, site_folder = os.path.split(package_path)
    py_prefix = os.path.abspath(sys.prefix)
    if package_path.startswith(py_prefix):
        return py_prefix, package_path
    elif site_folder.lower() == "site-packages":
        parent, folder = os.path.split(site_parent)
        # Windows like installations
        if folder.lower() == "lib":
            base_dir = parent
        # UNIX like installations
        elif os.path.basename(parent).lower() == "lib":
            base_dir = os.path.dirname(parent)
        else:
            base_dir = site_parent
        return base_dir, package_path
    return None, package_path


def _find_package_path(root_mod_name):
    """Find the path where the module's root exists in"""
    import importlib.util

    try:
        spec = importlib.util.find_spec(root_mod_name)
        if spec is None:
            raise ValueError("not found")
    # ImportError: the machinery told us it does not exist
    # ValueError:
    #    - the module name was invalid
    #    - the module name is __main__
    #    - *we* raised `ValueError` due to `spec` being `None`
    except (ImportError, ValueError):
        pass  # handled below
    else:
        # namespace package
        if spec.origin in {"namespace", None}:
            return os.path.dirname(next(iter(spec.submodule_search_locations)))
        # a package (with __init__.py)
        elif spec.submodule_search_locations:
            return os.path.dirname(os.path.dirname(spec.origin))
        # just a normal module
        else:
            return os.path.dirname(spec.origin)

    # we were unable to find the `package_path` using PEP 451 loaders
    loader = pkgutil.get_loader(root_mod_name)
    if loader is None or root_mod_name == "__main__":
        # import name is not found, or interactive/main module
        return os.getcwd()
    else:
        if hasattr(loader, "get_filename"):
            filename = loader.get_filename(root_mod_name)
        elif hasattr(loader, "archive"):
            # zipimporter's loader.archive points to the .egg or .zip
            # archive filename is dropped in call to dirname below.
            filename = loader.archive
        else:
            # At least one loader is missing both get_filename and archive:
            # Google App Engine's HardenedModulesHook
            #
            # Fall back to imports.
            __import__(root_mod_name)
            filename = sys.modules[root_mod_name].__file__
        package_path = os.path.abspath(os.path.dirname(filename))

        # In case the root module is a package we need to chop of the
        # rightmost part. This needs to go through a helper function
        # because of namespace packages.
        if _matching_loader_thinks_module_is_package(loader, root_mod_name):
            package_path = os.path.dirname(package_path)

    return package_path


def _matching_loader_thinks_module_is_package(loader, mod_name):
    """Given the loader that loaded a module and the module this function
    attempts to figure out if the given module is actually a package.
    """
    cls = type(loader)
    # If the loader can tell us if something is a package, we can
    # directly ask the loader.
    if hasattr(loader, "is_package"):
        return loader.is_package(mod_name)
    # importlib's namespace loaders do not have this functionality but
    # all the modules it loads are packages, so we can take advantage of
    # this information.
    elif cls.__module__ == "_frozen_importlib" and cls.__name__ == "NamespaceLoader":
        return True
    # Otherwise we need to fail with an error that explains what went
    # wrong.
    raise AttributeError(
        f"{cls.__name__}.is_package() method is missing but is required"
        " for PEP 302 import hooks."
    )
```

## 處理首次請求

```python
# tracks internally if the application already handled at least one
# request.
self._got_first_request = False
self._before_request_lock = Lock()


def try_trigger_before_first_request_functions(self):
    """Called before each request and will ensure that it triggers
    the :attr:`before_first_request_funcs` and only exactly once per
    application instance (which means process usually).

    :internal:
    """
    if self._got_first_request:
        return
    with self._before_request_lock:
        if self._got_first_request:
            return
        for func in self.before_first_request_funcs:
            func()
        self._got_first_request = True
```

## 自动更新 autoreload

```python
def update_template_context(self, context):
    """Update the template context with some commonly used variables.
    This injects request, session, config and g into the template
    context as well as everything template context processors want
    to inject.  Note that the as of Flask 0.6, the original values
    in the context will not be overridden if a context processor
    decides to return a value with the same key.

    :param context: the context as a dictionary that is updated in place
                    to add extra variables.
    """
    funcs = self.template_context_processors[None]
    reqctx = _request_ctx_stack.top
    if reqctx is not None:
        bp = reqctx.request.blueprint
        if bp is not None and bp in self.template_context_processors:
            funcs = chain(funcs, self.template_context_processors[bp])
    orig_ctx = context.copy()
    for func in funcs:
        context.update(func())
    # make sure the original values win.  This makes it possible to
    # easier add new variables in context processors without breaking
    # existing views.
    context.update(orig_ctx)
```

# 合并dict list

```python
# Merge app and self dictionaries.
def merge_dict_lists(self_dict, app_dict):
    """Merges self_dict into app_dict. Replaces None keys with self.name.
    Values of dict must be lists.
    """
    for key, values in self_dict.items():
        key = self.name if key is None else f"{self.name}.{key}"
        app_dict.setdefault(key, []).extend(values)

def merge_dict_nested(self_dict, app_dict):
    """Merges self_dict into app_dict. Replaces None keys with self.name.
    Values of dict must be dict.
    """
    for key, value in self_dict.items():
        key = self.name if key is None else f"{self.name}.{key}"
        app_dict[key] = value
```