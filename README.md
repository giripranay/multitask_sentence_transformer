# ML Apprentice Take-Home Project

## Overview

This project implements a sentence transformer model with multi-task learning capabilities using PyTorch and Hugging Face Transformers.

## Tasks

1. **Sentence Transformer Implementation**: Encodes input sentences into fixed-length embeddings.
2. **Multi-Task Learning Expansion**: Adds classification and sentiment analysis heads to the model.
3. **Training Considerations**: Discusses strategies for freezing layers and transfer learning.
4. **Training Loop Implementation**: Demonstrates a training loop for the multi-task model.



# Sentence Transformers & Multi-Task Learning

This project contains a Jupyter Notebook that explores the use of Sentence Transformers and Multi-Task Learning using PyTorch and Hugging Face Transformers. This `README` provides instructions for building and running the Docker container that encapsulates the environment needed to run the notebook.

##  Project Structure

* Dockerfile
* Sentence_Transformers_&_Multi_Task_Learning.ipynb
* writeup.md
* README.md
* requirements.txt

##  Getting Started

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed on your system.

### Setup

```bash
git clone https://github.com/giripranay/multitask_sentence_transformer.git
cd multitask_sentence_transformer
```

### Building the Docker Image

1. Open a terminal and navigate to the project directory.
2. Build the Docker image by running:

```bash
docker build -t sentence-transformer .
```

### Running the Docker Container
3. Once the image is built, you can start a container using:
```bash
docker run -p 8888:8888 sentence-transformer
```
### Accessing the Notebook

Open your browser and go to:

```bash
http://localhost:8888
```

