# Deep learning

[TOC]

# Introduction

## Developer environment
Using VS code developer containers. The installed extensions are listed in the devcontainer.json. The developer container (see Dockerfile) uses the miniconda base image from Microsoft. 

There are different ways to set up a virtual environment (virtualenv, anaconda, miniconda ...) for a python project. 

### Miniconda

Here, the miniconda was chosen. The main tool within miniconda is the **conda** environment and package manager.

As of now the miniconda base image provides the following conda version:

vscode ➜ /workspaces/miniconda (main) $ conda --version\
*conda 24.4.0*

### Useful conda commands

Check what environments are currently installed: **conda env list**\
Create a new environment: **conda create --name python_3_9  python=3.9 numpy pandas**\
Initialize the environments: **conda init --all**
Activate the environment (needs a new terminal): **conda activate python_3_9**
Save the installed packages into the requirements file: **pip freeze > requirements.txt**

### Python packages

*PyTorch Lightning* is the deep learning framework for professional AI researchers and machine learning engineers who need maximal flexibility without sacrificing performance at scale. Lightning evolves with you as your projects go from idea to paper/production.

Install pytorch with pip: ``pip install pytorch-lightning``\
Install using conda: ``conda install lightning -c conda-forge``

---

*Watermark* is an IPython magic extension for printing date and time stamps, version numbers, and hardware information.

Intallation ``pip install watermark``

---

*Matplotlib* is a comprehensive library for creating static, animated, and interactive visualizations in Python. Matplotlib makes easy things easy and hard things possible.

---

*NumPy* is the fundamental package for scientific computing in Python. It is a Python library that provides a multidimensional array object, various derived objects (such as masked arrays and matrices), and an assortment of routines for fast operations on arrays, including mathematical, logical, shape manipulation, sorting, selecting, I/O, discrete Fourier transforms, basic linear algebra, basic statistical operations, random simulation and much more.

---

*Pandas* is a fast, powerful, flexible and easy to use open source data analysis and manipulation tool, built on top of the Python programming language.

---

The environment can be checked by: [checker](jupyter_check_environment.ipynb)

## Perceptron

See the implemented jupyter model: [perceptron](./perceptron.ipynb).

# References

[1] https://lightning.ai/courses/deep-learning-fundamentals/
