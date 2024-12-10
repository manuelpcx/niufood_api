# README

1. Descripción del Proyecto
    El propósito de este backend es gestionar los siguientes conceptos:

    Restaurantes: Información básica sobre restaurantes.
    Dispositivos: Representan recursos vinculados a cada restaurante, con estados como operativo, fallando o mantenimiento.
    WebSocket en tiempo real: Sincronización automática entre la base de datos y el frontend.
    Utiliza Sidekiq + Redis para realizar tareas en segundo plano, como actualizaciones periódicas.

2. Requisitos Previo
    Antes de comenzar, asegúrate de tener instalados estos requisitos:

    Ruby 3.0.0 o superior
    Rails 7.x.x
    PostgreSQL (base de datos)
    Redis (para Sidekiq y ActionCable)
    Node.js (para dependencias de Rails)

3. Instalación

    Clona el repositorio
    https://github.com/manuelpcx/niufood_api.git

    Instala las gemas
        bundle install

    crea la base de datos
        rails db:create
        rails db:migrate

    Configuración:

    Iniciar redis: 
        redis-server
    Iniciar rails:
        rails s