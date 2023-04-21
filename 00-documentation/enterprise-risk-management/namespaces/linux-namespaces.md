# Linux Namespaces

## How to work with namespaces and rootless Docker

Table Of Contents

- [Linux Namespaces](#linux-namespaces)
  - [How to work with namespaces and rootless Docker](#how-to-work-with-namespaces-and-rootless-docker)
    - [Find the PID of rootless docker](#find-the-pid-of-rootless-docker)
    - [Enter the namespace of a PID](#enter-the-namespace-of-a-pid)
  - [Section 2](#section-2)
    - [Subsection 2.1](#subsection-21)
    - [Subsection 2.2](#subsection-22)

### Find the PID of rootless docker

```bash
ps ux | grep dockerd
```

The command `ps ux | grep dockerd` is used to display information about processes related to the Docker daemon. Here's how it works:

`ps` is a command used to display information about processes running on the system.

The `u` option for ps displays the process information in a user-friendly format that includes the user, CPU usage, and memory usage.

The `x` option for ps includes processes that do not have a controlling terminal, such as background processes.

The `|` character is a pipe, which redirects the output of the ps command to the grep command.

`grep` is a command used to search for a specific pattern in the output of a command.

`dockerd` is the name of the Docker daemon process. The `grep` command filters the output of the ps command to show only the lines that contain the string "`dockerd`".

Therefore, the `ps ux | grep dockerd` command lists all the running processes on the system, and filters the output to show only the processes related to the Docker daemon. This can be useful for finding the PID (process ID) of the Docker daemon, or for monitoring the resource usage of the Docker daemon process.

### Enter the namespace of a PID

```bash
sudo nsenter --target 961 --net
```

The `sudo nsenter --target 961 --net` command is used to enter the network namespace of a specific process ID (PID).

Here's what each part of the command means:

sudo: Run the command with administrative privileges.
nsenter: Run a program in a different namespace.
--target 961: Specify the PID of the process whose namespace you want to enter. In this case, the PID is 961.
--net: Specify that you want to enter the network namespace of the process.

## Section 2

### Subsection 2.1

### Subsection 2.2
