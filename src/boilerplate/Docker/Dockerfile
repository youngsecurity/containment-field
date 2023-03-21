#.SCRIPT NAME: Boilerplate for Dockerfile
#.AUTHOR: Joseph Young <joe@youngsecurity.net>
#.DATE: 3/20/2023
#.DOCUMENTATION: 
#.DESCRIPTION: This boilerplate starts with a base image (ubuntu:latest), specifies the maintainer, sets the working directory to /app,
# and copies the application files from the local machine to the container's /app directory.
# The RUN command installs required packages using apt-get and removes any unnecessary files to reduce the image size.
# The ENV command sets environment variables that will be available within the container.
# The EXPOSE command specifies the port on which the container will listen.
# Finally, the CMD command defines the command to be run when the container starts up. In this case, it specifies that the
# app.py script should be run using Python.
#.EXAMPLE: docker build -t my-image:latest .
# This command specifies a tag (my-image) and a version (latest) for the image, and tells Docker to use the current directory (.) as the build contex
# Once the build completes successfully, you can use the docker run command to start a container from the image:
#.EXAMPLE: docker run -p 8080:80 my-image:latest
# This command starts a container from the my-image:latest image and maps port 8080 on the host to port 80 in the container.
# And that's it! The container should now be running and accessible at http://localhost:8080 in your web browser.

# Base image
FROM ubuntu:latest

# Maintainer information
LABEL Your Name <your.email@example.com>

# Set working directory
WORKDIR /app

# Copy application files
COPY app /app

# Install required packages
RUN apt-get update && apt-get install -y \
    package1 \
    package2 \
    package3 \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV ENV_VAR1 value1
ENV ENV_VAR2 value2

# Expose port
EXPOSE 8080

# Define startup command
CMD [ "python", "app.py" ]