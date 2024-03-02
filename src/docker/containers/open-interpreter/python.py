from interpreter import interpreter
interpreter.chat("""Write a bash script using as few lines as possible.
                Do not install any dependencies or suggest using other software. 
                Do not use python. 
                Do not run code in the background.
                Do not redirect the code to `/dev/null`.
                I want to see the results in the terminal.
                First, SSH to devusr@10.0.255.44. 
                Second, use the ping binary to check if 8.8.8.8 is up by sending 3 pings and quit without waiting or sleeping. 
                Third, use "exit 0" and disconnect from SSH.""")

interpreter.chat("""Make sure the previous command finished.
                """)