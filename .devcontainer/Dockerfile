# Use an official Ubuntu as a parent image
FROM ubuntu:22.04

# Set environment variables for Conda
ENV PATH /opt/conda/bin:$PATH
ENV MYSQL_ROOT_PASSWORD=datajoint

# Install necessary system tools
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    ca-certificates \
    curl \
    git \
    webp \
    mysql-server \
    && rm -rf /var/lib/apt/lists/*

# Download and install Miniconda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    /bin/bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh && \
    conda clean --all -f -y 

# Install additional tools or packages as needed in the base environment
RUN conda init bash && \
    conda install -n base -c conda-forge python=3.10 jupyterlab numpy pandas 'nodejs>20,<21' pip -y && \
    pip install mystmd && \
    pip install jupyterlab_myst && \
    pip install datajoint

# Set up shell to use Conda by default
RUN echo "source /opt/conda/etc/profile.d/conda.sh && conda activate base" >> ~/.bashrc

# Configure MySQL to allow remote connections (optional)
RUN sed -i 's/bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Initialize MySQL with the root password
RUN service mysql start && \
    mysqladmin -u root password "$MYSQL_ROOT_PASSWORD" && \
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;"

# Expose ports for JupyterLab and MySQL
EXPOSE 3306

# Default command for the Devcontainer
CMD ["bash"]
