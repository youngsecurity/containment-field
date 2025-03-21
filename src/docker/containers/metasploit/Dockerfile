FROM metasploitframework/metasploit-framework

RUN apk update && apk add sudo \
    && adduser -D msfuser \
    && echo "msfuser:your-password" | chpasswd \
    && adduser msfuser wheel \
    && echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel \
    && chmod 440 /etc/sudoers.d/wheel

USER msfuser
WORKDIR /home/msfuser
CMD ["msfdb", "init"]
