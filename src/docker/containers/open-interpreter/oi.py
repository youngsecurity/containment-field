from interpreter import interpreter

interpreter.offline = True # Disables online features like Open Procedures
interpreter.llm.model = "dolphin-mistral:latest"
interpreter.llm.api_base = "http://10.0.255.147:11434/v1"

interpreter.chat("install ping and check if 8.8.8.8 is up") # Executes a single command