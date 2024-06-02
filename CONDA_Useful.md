# Useful conda commands
List environments:  ```conda env list```

Create a new environment: ```conda create --name env_1 python=3.9```

Initialize the environments (all!): ```conda init --all```
*NOTE: the initialization requires the environment reload:* ```source /home/vscode/.bashrc```

Activate the environment: ```conda activate env_1```

For jupyter notebooks and for watermark python package: ```conda install -n ai_python_3_9 ipykernel --update-deps --force-reinstall```
*NOTE: now it is added to the* ```environment_3_9.yml```*, will be installed at the time of the conda environment creation.*

pip install watermark