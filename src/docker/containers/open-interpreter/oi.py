from interpreter import interpreter

interpreter.offline = True # Disables online features like Open Procedures
interpreter.llm.model = "dolphin-mistral:latest"
#interpreter.llm.model = "deepseek-coder:6.7b"
#interpreter.llm.model = "llama2-uncensored:latest"

interpreter.llm.api_base = "http://10.0.255.147:11434/v1"

interpreter.llm.max_tokens = 1000
interpreter.llm.context_window = 3000

#interpreter.chat() # Executes a single command
#interpreter.chat("Use ping to check if 8.8.8.8 is up by sending 3 pings without waiting or sleeping. Do not try to install any dependencies and do not suggest using other software. Do not use sshpass. Do not use python. Use a bash script. Write as few lines as possible to perform the task.")
interpreter.chat("SSH to devusr@10.0.255.44, then disconnect from SSH. Do not install any dependencies or extra software.")



