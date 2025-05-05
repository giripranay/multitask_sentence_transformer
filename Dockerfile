# Use an official Python runtime as a base image
FROM python:3.8-slim

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    make \
    libsndfile1 \
    libgfortran5 \
    && rm -rf /var/lib/apt/lists/*

# Install Jupyter and other Python dependencies
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir \
    jupyter \
    torch \
    transformers \
    tqdm \
    scikit-learn \
    matplotlib \
    pandas \
    numpy \
    ipykernel

# Copy the notebook and any additional files into the container
COPY ./Sentence_Transformers_&_Multi_Task_Learning.ipynb /app/Sentence_Transformers_&_Multi_Task_Learning.ipynb

# Set the environment variable to not prompt for input during package installations
ENV DEBIAN_FRONTEND=noninteractive

# Expose port 8888 for Jupyter Notebook
EXPOSE 8888

# Set the command to start Jupyter notebook server
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--NotebookApp.token=''"]
