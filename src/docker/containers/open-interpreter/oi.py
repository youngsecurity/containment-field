from interpreter import interpreter

interpreter.offline = True # Disables online features like Open Procedures
interpreter.llm.model = "dolphin-mistral:latest"
#interpreter.llm.model = "deepseek-coder:6.7b"
#interpreter.llm.model = "llama2-uncensored:latest"

interpreter.llm.api_base = "http://10.0.255.147:11434/v1"

interpreter.llm.max_tokens = 1000
interpreter.llm.context_window = 3000

#interpreter.chat() # Executes a single command
#interpreter.chat("SSH to <user>@<host>, then disconnect from SSH. Do not install any dependencies or extra software.")
interpreter.chat("Use a bash script. Write as few lines as possible to perform the task. Do not install any dependencies or suggest using other software. Do not use python. I want you to first, SSH to devusr@10.0.255.44. Second, use the ping binary to check if 8.8.8.8 is up by sending 3 pings and quit without waiting or sleeping. Third, disconnect from SSH.")




