# 报错

```sh
File "/tmp/pip-build-fn9_nzes/pyarrow/setup.py", line 37, in <module>         from Cython.Distutils import build_ext as _build_ext     ModuleNotFoundError: No module named 'Cython'
```

解决:

pip3 install --upgrade cython

https://stackoverflow.com/questions/51608035/modulenotfounderror-no-module-named-cython-when-installing-pyarrow

https://stackoverflow.com/questions/43982543/importerror-no-module-named-cython

```sh
    -- Running cmake for pyarrow
    cmake -DPYTHON_EXECUTABLE=/usr/bin/python3 -DPython3_EXECUTABLE=/usr/bin/python3  -DPYARROW_BUILD_CUDA=off -DPYARROW_BUILD_FLIGHT=off -DPYARROW_BUILD_GANDIVA=off -DPYARROW_BUILD_DATASET=off -DPYARROW_BUILD_ORC=off -DPYARROW_BUILD_PARQUET=off -DPYARROW_BUILD_PLASMA=off -DPYARROW_BUILD_S3=off -DPYARROW_BUILD_HDFS=off -DPYARROW_USE_TENSORFLOW=off -DPYARROW_BUNDLE_ARROW_CPP=off -DPYARROW_BUNDLE_BOOST=off -DPYARROW_GENERATE_COVERAGE=off -DPYARROW_BOOST_USE_SHARED=on -DPYARROW_PARQUET_USE_SHARED=on -DCMAKE_BUILD_TYPE=release /tmp/pip-build-k_f64mkd/pyarrow
    -- The C compiler identification is GNU 7.5.0
    -- The CXX compiler identification is GNU 7.5.0
    -- Check for working C compiler: /usr/bin/cc
    -- Check for working C compiler: /usr/bin/cc -- works
    -- Detecting C compiler ABI info
    -- Detecting C compiler ABI info - done
    -- Detecting C compile features
    -- Detecting C compile features - done
    -- Check for working CXX compiler: /usr/bin/c++
    -- Check for working CXX compiler: /usr/bin/c++ -- works
    -- Detecting CXX compiler ABI info
    -- Detecting CXX compiler ABI info - done
    -- Detecting CXX compile features
    -- Detecting CXX compile features - done
    -- System processor: x86_64
    -- Performing Test CXX_SUPPORTS_SSE4_2
    -- Performing Test CXX_SUPPORTS_SSE4_2 - Success
    -- Performing Test CXX_SUPPORTS_AVX2
    -- Performing Test CXX_SUPPORTS_AVX2 - Success
    -- Performing Test CXX_SUPPORTS_AVX512
    -- Performing Test CXX_SUPPORTS_AVX512 - Success
    -- Arrow build warning level: PRODUCTION
    Using ld linker
    Configured for RELEASE build (set with cmake -DCMAKE_BUILD_TYPE={release,debug,...})
    -- Build Type: RELEASE
    -- Generator: Unix Makefiles
    -- Build output directory: /tmp/pip-build-k_f64mkd/pyarrow/build/temp.linux-x86_64-3.6/release
    -- Found PythonInterp: /usr/bin/python3 (found version "3.6.9")
    -- Searching for Python libs in /usr/lib64;/usr/lib;/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu
    -- Looking for python3.6m
    -- Found Python lib /usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/libpython3.6m.so
    -- Found PythonLibs: /usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/libpython3.6m.so
    -- Found NumPy: version "1.19.5" /home/turing/.local/lib/python3.6/site-packages/numpy/core/include
    -- Found Python3Alt: /usr/bin/python3
    -- Searching for Python libs in /usr/lib64;/usr/lib;/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu
    -- Looking for python3.6m
    -- Found Python lib /usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/libpython3.6m.so
    -- Found PkgConfig: /usr/bin/pkg-config (found version "0.29.1")
    -- Could NOT find Arrow (missing: Arrow_DIR)
    -- Checking for module 'arrow'
    --   No package 'arrow' found
    CMake Error at /usr/share/cmake-3.10/Modules/FindPackageHandleStandardArgs.cmake:137 (message):
      Could NOT find Arrow (missing: ARROW_INCLUDE_DIR ARROW_LIB_DIR
      ARROW_FULL_SO_VERSION ARROW_SO_VERSION)
    Call Stack (most recent call first):
      /usr/share/cmake-3.10/Modules/FindPackageHandleStandardArgs.cmake:378 (_FPHSA_FAILURE_MESSAGE)
      cmake_modules/FindArrow.cmake:419 (find_package_handle_standard_args)
      cmake_modules/FindArrowPython.cmake:46 (find_package)
      CMakeLists.txt:214 (find_package)
    
    
    -- Configuring incomplete, errors occurred!
    See also "/tmp/pip-build-k_f64mkd/pyarrow/build/temp.linux-x86_64-3.6/CMakeFiles/CMakeOutput.log".
    error: command 'cmake' failed with exit status 1
    
    ----------------------------------------
Command "/usr/bin/python3 -u -c "import setuptools, tokenize;__file__='/tmp/pip-build-k_f64mkd/pyarrow/setup.py';f=getattr(tokenize, 'open', open)(__file__);code=f.read().replace('\r\n', '\n');f.close();exec(compile(code, __file__, 'exec'))" install --record /tmp/pip-7ik3t__2-record/install-record.txt --single-version-externally-managed --compile --user --prefix=" failed with error code 1 in /tmp/pip-build-k_f64mkd/pyarrow/

```

解决:

pip3 install --no-cache pyarrow==0.9.0

https://github.com/apache/arrow/issues/1125



```sh
TypeError: dropout(): argument 'input' (position 1) must be Tensor, not str
```
https://stackoverflow.com/questions/65082243/dropout-argument-input-position-1-must-be-tensor-not-str-when-using-bert


# CUDA 内存爆掉了

```sh
RuntimeError: CUDA out of memory. Tried to allocate 20.00 MiB (GPU 0; 7.79 GiB total capacity; 288.62 MiB already allocated; 2.81 MiB free; 312.00 MiB reserved in total by PyTorch)
```
这是因为微型批处理数据不适合GPU内存。只需减小批次大小即可。当我为cifar10数据集设置批处理大小= 256时，出现了相同的错误；然后我将批处理大小设置为128，就可以解决。

https://github.com/pytorch/pytorch/issues/16417

import torch
torch.cuda.empty_cache()

https://stackoverflow.com/questions/59129812/how-to-avoid-cuda-out-of-memory-in-pytorch

設置多GPU并行

https://developer.nvidia.com/how-to-cuda-python

# pytorch的坑

https://www.zhihu.com/question/67209417/answer/302434279

# 更名

BERT_PRETRAINED_MODEL_ARCHIVE_MAP 变为 BERT_PRETRAINED_MODEL_ARCHIVE_LIST

https://github.com/huggingface/transformers/pull/4636

https://github.com/huggingface/transformers/issues/5842

# nvcc 和nvidia-smi显示版本 不一致
其实是因为CUDA 有两种API，分别是 运行时 API 和 驱动API，即所谓的 Runtime API 与 Driver API。
nvidia-smi 的结果除了有 GPU 驱动版本型号，还有 CUDA Driver API的型号，这里是 10.0。
而nvcc的结果是对应 CUDA Runtime API：
下图很清楚的展示前面提到的各种概念之间的关系，其中runtime和driver API在很多情况非常相似，也就是说用起来的效果是等价的，但是你不能混合使用这两个API，因为二者是互斥的。也就是说在开发过程中，你只能选择其中一种API。简单理解二者的区别就是：runtime是更高级的封装，开发人员用起来更方便，而driver API更接近底层，速度可能会更快。

https://www.jianshu.com/p/eb5335708f2a

https://zhuanlan.zhihu.com/p/91334380

https://docs.nvidia.com/datacenter/tesla/tesla-release-notes-450-102-04/

CUDA环境设置

export PATH=/usr/local/cuda-10.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64:$LD_LIBRARY_PATH
export CUDA_HOME=/usr/local/cuda-10.0

https://zhuanlan.zhihu.com/p/73787970

https://blog.csdn.net/ljp1919/article/details/102640512

Nvidia Cudatoolkit vs Conda Cudatoolkit 不一致

https://stackoverflow.com/questions/59529804/nvidia-cudatoolkit-vs-conda-cudatoolkit

https://www.cnblogs.com/yhjoker/p/10972795.html

https://varhowto.com/install-pytorch-cuda-10-2/



# 跟踪cuda报错

CUDA_LAUNCH_BLOCKING=1 python xxxx

CUDA_LAUNCH_BLOCKING=1 python [YOUR_PROGRAM]

https://stackoverflow.com/questions/61473330/cuda-error-cublas-status-alloc-failed-when-calling-cublascreatehandle

> 降级到1.7.1
```sh
# 收集cuda信息
(base) fang@ub:/data1/nlp/unilm/layoutlm/examples/seq_labeling$ python -m torch.utils.collect_env
Collecting environment information...
PyTorch version: 1.8.0
Is debug build: False
CUDA used to build PyTorch: 10.2
ROCM used to build PyTorch: N/A

OS: Ubuntu 18.04.2 LTS (x86_64)
GCC version: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
Clang version: Could not collect
CMake version: version 3.10.2

Python version: 3.8 (64-bit runtime)
Is CUDA available: True
CUDA runtime version: Could not collect
GPU models and configuration: 
GPU 0: GeForce RTX 2070
GPU 1: GeForce RTX 2070

Nvidia driver version: 450.51.05
cuDNN version: Probably one of the following:
/usr/lib/x86_64-linux-gnu/libcudnn.so.7.6.5
/usr/local/cuda-10.2/targets/x86_64-linux/lib/libcudnn.so.7.5.0
HIP runtime version: N/A
MIOpen runtime version: N/A

Versions of relevant libraries:
[pip3] numpy==1.19.2
[pip3] numpydoc==1.1.0
[pip3] torch==1.8.0
[pip3] torchaudio==0.8.0
[pip3] torchvision==0.9.0
[conda] blas                      1.0                         mkl    https://mirrors.ustc.edu.cn/anaconda/pkgs/free
[conda] cudatoolkit               11.0.221             h6bb024c_0    <unknown>
[conda] mkl                       2020.2                      256    defaults
[conda] mkl-service               2.3.0            py38he904b0f_0    defaults
[conda] mkl_fft                   1.2.0            py38h23d657b_0    defaults
[conda] mkl_random                1.1.1            py38h0573a6f_0    defaults
[conda] numpy                     1.19.2           py38h54aff64_0    defaults
[conda] numpy-base                1.19.2           py38hfa32c7d_0    defaults
[conda] numpydoc                  1.1.0              pyhd3eb1b0_1    defaults
[conda] torch                     1.8.0                    pypi_0    pypi
[conda] torchaudio                0.8.0                    pypi_0    pypi
[conda] torchvision               0.9.0                    pypi_0    pypi

pip install torch==1.8.0+cu110 torchvision==0.9.0+cu110 torchaudio==0.8.0 -f https://download.pytorch.org/whl/torch_stable.html

(base) fang@ub:/data1/nlp/unilm/layoutlm/examples/seq_labeling$ pip install torch==1.8.0+cu110 torchvision==0.9.0+cu110 torchaudio==0.8.0 -f https://download.pytorch.org/whl/torch_stable.html
Looking in indexes: https://pypi.doubanio.com/simple
Looking in links: https://download.pytorch.org/whl/torch_stable.html
WARNING: Keyring is skipped due to an exception: Failed to create the collection: Prompt dismissed..
ERROR: Could not find a version that satisfies the requirement torch==1.8.0+cu110 (from versions: 0.1.2, 0.1.2.post1, 0.1.2.post2, 1.4.0, 1.4.0+cpu, 1.4.0+cu100, 1.4.0+cu92, 1.5.0, 1.5.0+cpu, 1.5.0+cu101, 1.5.0+cu92, 1.5.1, 1.5.1+cpu, 1.5.1+cu101, 1.5.1+cu92, 1.6.0, 1.6.0+cpu, 1.6.0+cu101, 1.6.0+cu92, 1.7.0, 1.7.0+cpu, 1.7.0+cu101, 1.7.0+cu110, 1.7.0+cu92, 1.7.1, 1.7.1+cpu, 1.7.1+cu101, 1.7.1+cu110, 1.7.1+cu92, 1.7.1+rocm3.7, 1.7.1+rocm3.8, 1.8.0, 1.8.0+cpu, 1.8.0+cu101, 1.8.0+cu111, 1.8.0+rocm3.10, 1.8.0+rocm4.0.1)
ERROR: No matching distribution found for torch==1.8.0+cu110

# 降级成1.7.1+cu110的torch

(base) fang@ub:/data1/nlp/unilm/layoutlm/examples/seq_labeling$ pip install torch==1.7.1+cu110 torchvision==0.8.2+cu110 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html

# 1.8.0 的torch

pip install torch==1.8.0+cu111 torchvision==0.9.0+cu111 torchaudio==0.8.0 -f https://download.pytorch.org/whl/torch_stable.html

https://pytorch.org/get-started/previous-versions/
```


https://discuss.pytorch.org/t/cuda-error-cublas-status-internal-error-when-calling-cublascreate-handle/114341/3

# 悟道微调CHID

```sh
(base) fang@ub:/data1/nlp/wudao/CPM-Finetune-main$ bash scripts/chid/finetune_chid_large_fp32.sh
*****************************************
Setting OMP_NUM_THREADS environment variable for each process to be 1 in default, to avoid your system being overloaded, please further tune the variable for optimal performance in your application as needed. 
*****************************************
using world size: 8 and model-parallel size: 2 
 > using dynamic loss scaling
Traceback (most recent call last):
Traceback (most recent call last):
Traceback (most recent call last):
  File "finetune_chid.py", line 357, in <module>
  File "finetune_chid.py", line 357, in <module>
  File "finetune_chid.py", line 357, in <module>
Traceback (most recent call last):
Traceback (most recent call last):
Traceback (most recent call last):
  File "finetune_chid.py", line 357, in <module>
  File "finetune_chid.py", line 357, in <module>
  File "finetune_chid.py", line 357, in <module>
    main()
  File "finetune_chid.py", line 215, in main
    main()
  File "finetune_chid.py", line 215, in main
        main()main()

      File "finetune_chid.py", line 215, in main
  File "finetune_chid.py", line 215, in main
main()    
main()
  File "finetune_chid.py", line 215, in main
  File "finetune_chid.py", line 215, in main
    initialize_distributed(args)
  File "/data1/nlp/wudao/CPM-Finetune-main/utils.py", line 544, in initialize_distributed
    initialize_distributed(args)
  File "/data1/nlp/wudao/CPM-Finetune-main/utils.py", line 544, in initialize_distributed
    initialize_distributed(args)
      File "/data1/nlp/wudao/CPM-Finetune-main/utils.py", line 544, in initialize_distributed
initialize_distributed(args)
  File "/data1/nlp/wudao/CPM-Finetune-main/utils.py", line 544, in initialize_distributed
        initialize_distributed(args)initialize_distributed(args)

  File "/data1/nlp/wudao/CPM-Finetune-main/utils.py", line 544, in initialize_distributed
  File "/data1/nlp/wudao/CPM-Finetune-main/utils.py", line 544, in initialize_distributed
    torch.cuda.set_device(device)
  File "/data1/anaconda3/lib/python3.8/site-packages/torch/cuda/__init__.py", line 263, in set_device
        torch.cuda.set_device(device)torch.cuda.set_device(device)

  File "/data1/anaconda3/lib/python3.8/site-packages/torch/cuda/__init__.py", line 263, in set_device
  File "/data1/anaconda3/lib/python3.8/site-packages/torch/cuda/__init__.py", line 263, in set_device
    torch.cuda.set_device(device)
  File "/data1/anaconda3/lib/python3.8/site-packages/torch/cuda/__init__.py", line 263, in set_device
    torch.cuda.set_device(device)
    torch.cuda.set_device(device)  File "/data1/anaconda3/lib/python3.8/site-packages/torch/cuda/__init__.py", line 263, in set_device

  File "/data1/anaconda3/lib/python3.8/site-packages/torch/cuda/__init__.py", line 263, in set_device
    torch._C._cuda_setDevice(device)
RuntimeError: CUDA error: invalid device ordinal
    torch._C._cuda_setDevice(device)
RuntimeError: CUDA error: invalid device ordinal
    torch._C._cuda_setDevice(device)
RuntimeError: CUDA error: invalid device ordinal        
torch._C._cuda_setDevice(device)torch._C._cuda_setDevice(device)

RuntimeErrorRuntimeError: : CUDA error: invalid device ordinal    CUDA error: invalid device ordinal
torch._C._cuda_setDevice(device)

RuntimeError: CUDA error: invalid device ordinal


```

## forward compatibility was attempted on non supported HW


```sh
(/data1/anaconda3/nlp) fang@ub:/data1/nlp/transformer-xl/pytorch$ lsmod | grep nvidia
nvidia_uvm            978944  2
nvidia_drm             49152  6
nvidia_modeset       1179648  6 nvidia_drm
nvidia              19628032  316 nvidia_modeset,nvidia_uvm
drm_kms_helper        167936  1 nvidia_drm
drm                   401408  9 nvidia_drm,drm_kms_helper

# 找到正在运行的nvidia程序
sudo lsof /dev/nvidia*
```

https://github.com/pytorch/pytorch/issues/40671

https://stackoverflow.com/questions/43022843/nvidia-nvml-driver-library-version-mismatch/45319156#45319156

https://comzyh.com/blog/archives/967/

# nvidia-smi报错

nvidia-smi
Failed to initialize NVML: Driver/library version mismatch

```
(base) fang@ub:/data1/nlp/transformer-xl/pytorch$ locate nvidia-smi
/home/fang/.local/share/fish/generated_completions/nvidia-smi.fish
/usr/bin/nvidia-smi
/usr/share/doc/nvidia-driver-450/html/nvidia-smi.html
/usr/share/doc/nvidia-utils-450/nvidia-smi.html
/usr/share/man/man1/nvidia-smi.1.gz
```

