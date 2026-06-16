# Inception - 42 School

A local infrastructure project managed with **Docker** and **Makefile**.

## Overview
This project sets up a virtual infrastructure featuring:
* **NGINX:** Configured with TLSv.1.2/1.3.
* **WordPress:** PHP-FPM integrated.
* **MariaDB:** Database service.

## Project Structure
A simple setup using Docker containers connected via a private network, with persistent data managed by local volumes.

## How to run
1. Clone the repo.
2. Create `secrets/` directory with your password files and a `.env` file.
3. Use the Makefile:
    ```bash
    make            # Build and start services
    make down       # Stop and remove containers
    make fclean     # Full cleanup
    make re         # Full cleanup and make up

# Docker Hub
Images are hosted on [View project on Docker Hub](https://hub.docker.com/repository/docker/ahmadbaniamer/inception/general)