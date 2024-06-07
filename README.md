# Deep learning tutorial

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

PyTorch Lightning is the deep learning framework for professional AI researchers and machine learning engineers who need maximal flexibility without sacrificing performance at scale. Lightning evolves with you as your projects go from idea to paper/production.

Install pytorch with pip: ``pip install pytorch-lightning``\
Install using conda: ``conda install lightning -c conda-forge``

Watermark is an IPython magic extension for printing date and time stamps, version numbers, and hardware information.

Intallation ``pip install watermark``


## Perceptron

Bla bla
