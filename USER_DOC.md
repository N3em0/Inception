# User documentation

## Prerequisites

This documentation assume that you've got a correctly setted up environment.

- Correct credentials
- Docker, Docker Compose installed
- Correct data volumes set up
- Repository cloned

If you are missing any of those,
see `DEV_DOC.md` for a full walkthrough.

## Services provided

| **Services**  | Description                                                                           |
|---------------|---------------------------------------------------------------------------------------|
| **Nginx**     | The web server, handling all HTTP/HTTPS requests and securing the connection via TLS. |
| **MariaDB**   | The database storing all WordPress data.                                              |
| **WordPress** | The content management system (CMS), to create and manage website content.            |

## Start and stop the project

##### Build and first start

```bash
make run 
```

##### Stop, delete containers and all persistent datas

```bash
make reset 
```

##### Stop and delete only containers

```bash
make down 
```

##### Stop containers

```bash
make stop 
```

##### Restart stopped containers

```bash
make start 
```

## Access the website and the administration panel

#### Access website

Go to [egache.42.fr](https://egache.42.fr).

#### Access administration panel

Go to [egache.42.fr/wp-admin](https://egache.42.fr/wp-admin).  

You will need to connect with :

- login (`WP_USER_LOGIN` or `WP_ADMIN_LOGIN`)
- password (`WP_USER_PASS` or `WP_ADMIN_PASS`)

See [credentials](#locate-and-manage-credentials)

## Locate and manage credentials

Unsensitive credentials may be found in `srcs/.env` file

`DB_NAME`
`DB_HOST`
`DB_USER`
`DOMAIN_NAME`
`WP_ADMIN_LOGIN`
`WP_ADMIN_EMAIL`
`WP_USER_LOGIN`
`WP_USER_EMAIL`

Passwords can be found in `secrets/` each in a `.txt` file

## Check that the services are running correctly

##### Check containers state

```bash
make ps 
```
