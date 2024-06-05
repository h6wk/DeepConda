FROM mcr.microsoft.com/devcontainers/miniconda:0-3

RUN mkdir `date '+%s'` && echo `pwd`

# Copy environment_3_9.yml (if found) to a temp location so we update the base environment. Also
# copy "noop.txt" so the COPY instruction does not fail if no environment.yml exists.
COPY environment.yml* .devcontainer/noop.txt .devcontainer/environment_3_9.yml /tmp/conda-tmp/
RUN if [ -f "/tmp/conda-tmp/environment_3_9.yml" ]; then umask 0002 && /opt/conda/bin/conda env update -n base -f /tmp/conda-tmp/environment_3_9.yml; fi

# Additional packages for the jupiter notebook:
RUN pip install watermark

# Dump the installed package list in the form of the requirements yaml file:
#RUN pip freeze > /workspaces/DeepConda/requirements_3_9_PON.yml

# NOTE: base environment was updated using the environment_3_9.yml

# The followings not needed now, don't need additional environment for now
#RUN conda env create -f /tmp/conda-tmp/environment_3_9.yml
#RUN rm -rf /tmp/conda-tmp
#RUN sudo chown -R vscode:vscode /opt/conda/envs/ai_python_3_9/
#RUN conda init --all

# [Optional] Uncomment to install a different version of Python than the default
# RUN conda install -y python=3.6 \
#     && pip install --no-cache-dir pipx \
#     && pipx reinstall-all

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>
