# Developer documentation

## Introduction

This project is about building a WordPress infrastructure using Docker and Docker Compose

The goal of this document, is to set up from scratch this Inception stack.

### Services provided

| **Services**  | Description                                                                           |
|---------------|---------------------------------------------------------------------------------------|
| **Nginx**     | The web server, handling all HTTP/HTTPS requests and securing the connection via TLS. |
| **MariaDB**   | The database storing all WordPress data.                                              |
| **WordPress** | The content management system (CMS), to create and manage website content.            |

## Prerequisites

### 1. Set up data directories

Create 2 directory to store persistents datas from `WordPress` and `MariaDB` containers.  

Do the command  
```bash
mkdir -p /home/egache/data/wp-data /home/egache/data/db-data
```

### 2. Redirect the website URL to localhost

Add this line to `/etc/hosts` file.
```bash
127.0.0.1       egache.42.fr
```
We need to link the url to localhost for our local Nginx and WordPress to handle the request.
```
```

### 3. Define .env variables

Create a `.env` file in `Inception/srcs/`

Add the following example variables. Change them at your will.
```bash
DB_NAME=database
DB_HOST=mariadb
DB_USER=user
DOMAIN_NAME=egache.42.fr
WP_ADMIN_LOGIN=egache
WP_ADMIN_EMAIL=egache@student.42lyon.fr
WP_USER_LOGIN=user
WP_USER_EMAIL=user@user.fr
```

Those variables are used during containers setup scripts and variables ***shouldn't*** be changed.

### 4. Define secrets variables

Go to the root of the project and copy paste this command. Those are examples password. Change them at your will
```bash
```bash
mkdir secrets
echo "root" > secrets/db_root_password.txt
echo "user" > secrets/db_user_password.txt
echo "egache" > secrets/wp_admin_password.txt
echo "user" > secrets/wp_user_password.txt
```

These passwords are used during containers setup scripts, are strictly personal and ***shouldn't*** be changed

## Build and launch the project

Once the environment is properly set up, you can build and start the infrastructure.

```bash
make run
```
This command executes `docker compose up --build -d`. It reads the `docker-compose.yml` file, builds the custom images from the Dockerfiles, sets up the isolated network, and starts all services in the background.

## Manage containers and volumes

#### View live logs
```bash
docker compose logs -f
```
Monitor the containers startup and allow to check for any errors.

#### Enter a running container
```bash
docker exec -it <container_name> sh
```
Open a shell inside the isolated container to manually check if configuration files, permissions, or secrets are correctly setted-up.

#### Inspect Docker objects
```bash
docker network ls
docker volume ls
```
Check that custom bridge network and the persistent volumes are successfully created.

#### Complete reset
```bash
make reset
```
Executes `docker compose down -v && docker system prune -a`. It stops the containers, destroys the internal docker volumes and networks, and also all the persistents datas.

## Data persistence and storage

By design, Docker containers are ephemeral. If a container is destroyed, its internal data is lost. To prevent this, data is stored on the host machine.
Datas inside docker containers are losts once the container is destroyed. To prevent this, datas are stored on the host machine to ensure data persistence. 
*   **Database:** MariaDB data is located at `/home/egache/data/db-data`
*   **Website:** WordPress files are located at `/home/egache/data/wp-data`

Use **Named Volumes with a local bind driver** in Docker Compose file.
