How to run ollama with all GPUs on the docker host default bridge network

```bash
docker run -d --gpus=all -v ollama:/root/.ollama -p 11434:11434 --name ollama-int ollama/ollama
```

How to run ollama with all GPUs on a macvlan with a static IP

```bash
docker run -d --gpus=all --network=macvlan255 --ip 10.0.255.147 -v ollama:/root/.ollama --name ollama-ext --restart always ollama:latest
```

How to build the Docker image from source

```bash
docker build -t ollama .
```