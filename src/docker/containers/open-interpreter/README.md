# [Dockerfile](https://docs.openinterpreter.com/integrations/docker)

## How to build the Docker container for open-interpreter

```bash
# Start with Python 3.11
FROM python:3.11

# Replace <your_openai_api_key> with your own key
ENV OPENAI_API_KEY <your_openai_api_key>

# Install Open Interpreter
RUN pip install open-interpreter

WORKDIR /root
```

Then in the same directory run:

```bash
docker build -t openinterpreter . 

# Add to the interpreter command that runs in the container this info telling it to connect to Mistral:
docker run -dit -v /path/on/your/host:/path/in/the/container --name open-interpreter openinterpreter interpreter --model dolphin-mistral:latest --api_base http://<ollama-ip>:11434/v1

# Examples
#docker run -dit -v $(pwd):/files --name interpreter-instance openinterpreter interpreter

# Using dolphin-mistral
docker run -dit --network=macvlan255 --ip 10.0.255.151 --gpus=all -v ~/GitHub/ai-open-interpreter:/files --name open-interpreter openinterpreter interpreter --model dolphin-mistral:latest --api_base http://10.0.255.147:11434/v1

# Launch the container with no model loaded
docker run -dit --network=macvlan255 --ip 10.0.255.151 --gpus=all -v ~/GitHub/ai-open-interpreter:/files --name open-interpreter openinterpreter

# Example using flags
#docker run -dit openinterpreter interpreter --custom_instructions "Be as concise as possible"

docker attach open-interpreter
```

# Mounting Volumes

This is how you let it access some files, by telling it a folder (a volume) it will be able to see / manipulate.

To mount a volume, you can use the -v flag followed by the path to the directory on your host machine, a colon, and then the path where you want to mount the directory in the container.

```bash
docker run -d -it -v /path/on/your/host:/path/in/the/container --name interpreter-instance openinterpreter interpreter
```

Replace `/path/on/your/host` with the path to the directory on your host machine that you want to mount, and replace `/path/in/the/container` with the path in the Docker container where you want to mount the directory.

Here’s a simple example:

```bash
docker run -d -it -v $(pwd):/files --name interpreter-instance openinterpreter interpreter
```

In this example, `$(pwd)` is your current directory, and it is mounted to a `/files` directory in the Docker container (this creates that folder too).

# Flags

Please note that some flags will not work. For example, `--config` will not work, because it cannot open the config file in the container. If you want to use a config file other than the default, you can create a `config.yml` file inside of the same directory, add your custom config, and then run the following command:

```bash
docker-compose run --rm oi interpreter --config_file config.yml
```

## Best Practices

- Avoid asking it to perform potentially risky tasks. This seems obvious, but it’s the number one way to prevent safety mishaps.
    
- Run it in a sandbox. This is the safest way to run it, as it completely isolates the code it runs from the rest of your system.
    
- Use trusted models. Yes, Open Interpreter can be configured to run pretty much any text-based model on huggingface. But it does not mean it’s a good idea to run any random model you find. Make sure you trust the models you’re using. If you’re not sure, run it in a sandbox. Nefarious LLM’s are becoming a real problem, and they are not going away anytime soon.
    
- Local models are fun! But GPT-4 is probably your safest bet. OpenAI has their models aligned in a major way. It will outperform the local models, and it will generally refuse to run unsafe code, as it truly understands that the code it writes could be run. It has a pretty good idea what unsafe code looks like, and will refuse to run code like `rm -rf /` that would delete your entire disk, for example.
    
- The [—safe_mode](https://docs.openinterpreter.com/safety/safe-mode) argument is your friend. It enables code scanning, and can use [guarddog](https://github.com/DataDog/guarddog) to identify malicious PyPi and npm packages. It’s not a perfect solution, but it’s a great start.