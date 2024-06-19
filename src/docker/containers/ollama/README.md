# Ollama

Self hosted language models. 

## How to build

How to build the Docker image from source

```bash
docker build -t ollama . --no-cache
```

## How to run

How to run ollama with all GPUs on the docker host default bridge network

```bash
docker run -d --gpus=all -v ollama:/root/.ollama -p 11434:11434 --hostname ollama --name ollama ollama/ollama:latest
```

How to run ollama with all GPUs on a macvlan with a static IP

```bash
docker run -d --gpus=all --network=macvlan255 --ip 10.0.255.147 -v ollama:/root/.ollama --hostname ollama --name ollama --restart always ollama/ollama:latest
```

How to run ollama with a single GPU using NVIDIA device_ids

```bash
docker run -d --gpus=0 --network=macvlan255 --ip 10.0.255.147 -v ollama:/root/.ollama --hostname ollama --name ollama --restart always ollama/ollama:latest
```

## How to update

```shell
./test.sh "0.1.44" "0.1.44" "ollama" "ollama" "" "ollama-test"

docker stop ollama && \
docker rm ollama && \
# Run Ollama with all GPUs
docker run -d --gpus=all --network=macvlan255 --ip 10.0.255.147 -v ollama:/root/.ollama --hostname ollama --name ollama --restart always ollama:latest
# Run Ollama with a dedicated GPU using the GPU ID
docker run -d --gpus=0 --network=macvlan255 --ip 10.0.255.147 -v ollama:/root/.ollama --hostname ollama --name ollama --restart always ollama:latest
# Run Ollama with a dedicated GPU using the GPU UUID
docker run -d --gpus=GPU-fcc90235-d4c3-65e4-f064-446367f1cb5c --network=macvlan255 --ip 10.0.255.147 -v ollama:/root/.ollama --hostname ollama --name ollama --restart always ollama:latest
```

# Models

```shell
root@ollama:/# ollama list
NAME                                                    ID              SIZE    MODIFIED     
hub/shahzebnaveed/azure-solutions-architect:latest      fd839e036786    3.8 GB  4 weeks ago 
hub/cyber-security-specialist:latest                    5e9e5a95f6c9    4.1 GB  3 days ago  
dolphin-mistral:latest                                  ecbf896611f5    4.1 GB  8 days ago  
llama2-uncensored:latest                                44040b922233    3.8 GB  8 days ago  
mistral:latest                                          61e88e884507    4.1 GB  3 days ago  
nomic-embed-text:latest                                 0a109f422b47    274 MB  25 hours ago
openchat:7b-v3.5-q8_0                                   663a54b072bf    7.7 GB  8 days ago  
pxlksr/opencodeinterpreter-ds:latest                    1e582e157f36    3.8 GB  8 days ago  
```

## How to list GPUs

```bash
sudo nvidia-smi -L
GPU 0: NVIDIA GeForce RTX 3080 (UUID: GPU-fcc90235-d4c3-65e4-f064-446367f1cb5c)
GPU 1: NVIDIA GeForce GTX 1080 Ti (UUID: GPU-74ce157d-a287-99ff-51bd-810dcae70ec0)
```

> Note - Sometimes Ollama will fail to discover your NVIDIA GPU, and fallback to running on the CPU. You can workaround this driver bug by reloading the NVIDIA UVM driver with `sudo rmmod nvidia_uvm && sudo modprobe nvidia_uvm`