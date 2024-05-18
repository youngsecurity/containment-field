# [youngsecurity/ai-ollama-webui](https://github.com/youngsecurity/ai-ollama-webui)

## Default Examples

- How to run open-webui (ollama-webui) and connect to Ollama running on another server (container), change the `OLLAMA_API_BASE_URL` to use the Ollama server (container) IP or hostname:

```bash
docker run -d -p 3000:8080 -e OLLAMA_API_BASE_URL=https://[ollama-server-ip]/api -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```

- How to run open-webui (ollama-webui) and connect to Ollama on the same Docker host:

```bash
docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```

### Host file entry

10.0.255.148 ollama-webui ollama-webui.youngsecurity.net

### Configuration

How to run ollama-webui (open-webui) on a macvlan with a static IP with ollama running in that same macvlan with a hardcoded IP

```bash
docker run -d --network=macvlan255 --ip 10.0.255.148 -e OLLAMA_API_BASE_URL=http://10.0.255.147:11434/api -v open-webui:/app/backend/data --name open-webui-ext --restart always open-webui:latest
```

How to run ollama-webui (open-webui) from the docker host when ollama is on a different (macvlan) network

```bash
docker run -d -p 3000:8080 -e OLLAMA_API_BASE_URL=http://10.0.255.147:11434/api -v ollama-webui:/app/backend/data --name ollama-webui-1 --restart always ollama-webui
```

Here are the commands to run both ollama with all GPUs and open-webui (ollama-webui) on the same docker host and be able to access these container services from that same docker host. 

It is assumed that the NVIDIA Container Toolkit has been installed in the Docker host, and that the Docker host has been configured to use the NVIDIA runtime by default. 

- Step 1: Run ollama Docker image with all GPUs, the default bridge network, and the default TCP port on the docker host

```bash
docker run -d --gpus=all -v ollama:/root/.ollama -p 11434:11434 --name ollama-localhost ollama/ollama
```

- Step 2: Get the IP address of the ollama container running on the Docker default bridge network

```bash
docker inspect ollama-localhost | grep "IPAddress"
```

- Step 3: Modify the `OLLAMA_API_BASE_URL` environment variable to use the IP address of the ollama container and run the open-webui (ollama-webui) Docker image. The webui will find and connect to ollama on the default Docker bridge network using the default TCP ports and the private IP of the ollama container.

```bash
docker run -d -p 3000:8080 -e OLLAMA_API_BASE_URL=http://172.17.0.4:11434/api -v open-webui:/app/backend/data --name open-webui-localhost --restart always open-webui:latest
```

You can now access the Ollama webui from the docker host using `http://127.0.0.1:3000/`
