*This project has been created as part of the 42 curriculum by egache.*

## Description
Inception is a system administration project. The goal is to build a containerized WordPress infrastructure using Docker and Docker Compose. It deploys 3 services: MariaDB, WordPress, and Nginx.

## Instructions
1. **Configure local DNS:** Add `127.0.0.1 egache.42.fr` to your host's `/etc/hosts` file.
2. **Setup Directories:** Create local data folders at `/home/egache/data/db-data` and `/home/egache/data/wp-data`.
3. **Configure Environment:** Create `.env` file and fill it. Create required passwords inside the `secrets/` directory.
4. **Launch:** Run `make run` in the root directory.
5. **Access:** Open `https://egache.42.fr` in your browser.

## Resources
* Docker, Nginx, and MariaDB official documentation.
* [Stephane Robert](https://blog.stephane-robert.info/docs/conteneurisation/)
* [GradeMe](https://inception.cluzet.fr/#docker)
* **AI Usage:** An AI assistant was used for debugging bash initialization scripts, explaining Docker concepts, and answering unresolved questions.

## Technical Choices & Infrastructure

This project relies entirely on Docker to containerize services. Here are the main design choices:

### Alpine Linux vs Debian
Debian provides a more compatible environment with standard GNU tools..  
Alpine Linux is more minimalistic, security-focused based on `musl`.  
Using Alpine drastically reduces the container's final image size. But Debian is easier to configure.

### Virtual Machines vs Docker
Virtual Machines emulate full hardware and require a heavy guest operating system.  
Docker shares the host's OS kernel. It makes containers lightweight, fast to start, and highly resource-efficient.

### Secrets vs Environment Variables
Environment variables can leak through crash reports or process lists (`ps`).  
Docker Secrets mount sensitive data as temporary files in RAM (`tmpfs`). It is much more secure for passwords.

### Docker Network vs Host Network
The host network binds container ports directly to the host system, removing isolation.  
Docker bridge network creates a isolated network. Only Nginx is exposed to the outside. MariaDB and WordPress are hidden.

### Docker Volumes vs Bind Mounts
Standard Docker volumes are stored and managed by Docker.  
Pure bind mounts directly link a host folder to a container.  
In this project, I used a hybrid approach: **Named Volumes stored locally**. The volumes are declared in Docker (using `driver: local`), but  `driver_opts` (`type: none`, `o: bind`) force the physical data storage to a specific host path (`/home/egache/data/`).
