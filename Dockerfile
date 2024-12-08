FROM nginx:latest

# Installer OpenSSL pour générer des certificats auto-signés
RUN apt-get update && apt-get install -y openssl && apt-get clean

# Créer des répertoires pour les certificats SSL
RUN mkdir -p /etc/nginx/certs

# Générer un certificat SSL auto-signé
RUN openssl req -x509 -nodes -newkey rsa:2048 \
    -keyout /etc/nginx/certs/privkey.pem \
    -out /etc/nginx/certs/fullchain.pem \
    -days 365 -subj "/CN=localhost"

# Copier les fichiers de configuration et les contenus HTML
COPY index.html /usr/share/nginx/html/index.html
COPY site/404.html /usr/share/nginx/html/404.html
COPY default.conf /etc/nginx/conf.d/default.conf

# Exposer les ports HTTP et HTTPS
EXPOSE 80 443

# Lancer Nginx
CMD ["nginx", "-g", "daemon off;"]
