# Utilizamos Ubuntu 20.04 como base
FROM ubuntu:20.04

# Configuración de locales, zona horaria y actualización de paquetes
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Santiago

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    gnupg \
    git \
    libpq-dev \
    nodejs \
    npm \
    software-properties-common \
    libssl-dev \
    zlib1g-dev \
    libreadline-dev \
    libyaml-dev \
    libxml2-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    libffi-dev \
    wget \
    sudo && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Agregar repositorio oficial de PostgreSQL y configurar cliente
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt focal-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update -y && \
    apt-get install -y postgresql-client-12 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Configuración de Ruby
ENV RUBY_VERSION=3.1.6
RUN wget https://cache.ruby-lang.org/pub/ruby/3.1/ruby-$RUBY_VERSION.tar.gz && \
    tar -xzvf ruby-$RUBY_VERSION.tar.gz && \
    cd ruby-$RUBY_VERSION && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf ruby-$RUBY_VERSION*

# Configuración de Rails
ENV RAILS_VERSION=7.2.2
RUN gem install rails -v $RAILS_VERSION

# Instalación de Bundler
RUN gem install bundler

# Configuración del directorio de la aplicación
WORKDIR /app

# Copiamos el código fuente de la aplicación al contenedor
COPY . .

# Instalación de las dependencias de la aplicación
RUN bundle install

# Precompilación de los assets (si es necesario)
RUN rails assets:precompile || true

# Exponemos el puerto 3000 para el servidor Rails
EXPOSE 3000

# Comando por defecto para iniciar el servidor
CMD ["rails", "server", "-b", "0.0.0.0"]
