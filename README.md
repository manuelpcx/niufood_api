# README

1. Descripción del Proyecto
    El propósito de este backend es gestionar los siguientes conceptos:

    Restaurantes: Información básica sobre restaurantes.
    Dispositivos: Representan recursos vinculados a cada restaurante, con estados como operativo, warning o Problemas.
    WebSocket en tiempo real: Sincronización automática entre la base de datos y el frontend.
    Utiliza Sidekiq + Redis para realizar tareas en segundo plano, como actualizaciones periódicas.

2. Requisitos Previo
    Antes de comenzar, asegúrate de tener instalados estos requisitos:

    Ruby 3.0.0 o superior
    Rails 7.2.2
    PostgreSQL (base de datos)
    Redis (para Sidekiq y ActionCable)
    Node.js (para dependencias de Rails)
    Docker

3. Instalación

    Clona el repositorio
    https://github.com/manuelpcx/niufood_api.git

    correr comando de docker:
    - docker-compose build
    - docker-compose up
    - docker ps
    Tomamos el id del contenedor niufoods_api-app
    - docker exec -it "id contenedor" /bin/bash
    dentro del contenedor escribimos los siguientes comandos
    - rails db:migrate
    - rails db:seed
    luego que tengamos el front levantados, proseguimos con el ultimo comando para que empiece la magia
    - ruby simulta_restaurant.rb