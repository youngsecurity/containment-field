from interpreter import interpreter

interpreter.offline = True # Disables online features like Open Procedures
interpreter.llm.model = "ollama/dolphin-mistral:latest"
interpreter.llm.api_base = "http://10.0.255.147:11434/v1"

interpreter.llm.max_tokens = 1000
interpreter.llm.context_window = 3000

interpreter.chat() # Executes a single command
#interpreter.chat("install ping and check if 8.8.8.8 is up")