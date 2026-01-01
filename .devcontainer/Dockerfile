FROM mcr.microsoft.com/devcontainers/miniconda:3

# Set environment variables for Conda
ENV PATH=/opt/conda/bin:$PATH
ENV DJ_HOST=localhost
ENV DJ_PASS=$DJ_PASS
ENV DJ_USER=$DJ_USER

# Install system dependencies including netcat for connection checking
RUN apt-get update && apt-get install -y \
    wget \
    vim \
    curl \
    git \
    netcat-openbsd \
    default-mysql-client \
    && rm -rf /var/lib/apt/lists/*

# Install additional tools or packages as needed in the base environment
RUN conda init bash && \
    conda install -n base -c conda-forge python-graphviz jupyter jupysql 'nodejs>20,<21' && \
    pip install mystmd && \
    pip install jupyterlab_myst && \
    pip install scikit-image pooch && \
    pip uninstall -y datajoint || true && \
    pip install git+https://github.com/datajoint/datajoint-python.git@claude/upgrade-adapted-type-1W3ap


# Expose ports for JupyterLab and MySQL
EXPOSE 8888
