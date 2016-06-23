# Site web du caméra club de Martigny

## Développement
 
 L'idéal est d'avoir un virtualenv python. Si virtualenvwrapper est installé: `mkvirtualenv camera_club`.
 
 Pour commencer à travailler:
 
- pip install -e .

## Installation

### Macosx

Il est possible d'installer docker avec home brew `brew install docker docker-machine docker-compose docker-machine-driver-xhyve`.

Depuis Macosx 10.10 il est possible d'utiliser xhyve pour à la place de VirtualBox. On peut créer une nouvelle machine avec `docker-machine create -d xhyve cameraclub`.

### Configuration de docker

Après un reboot il faut s'assurer que la machine est up and running, sinon `docker-machine start cameraclub`.

Une fois la machine démarée dans le terminal on set les variables d'environnement avec `eval $(docker-machine env cameraclub)`.

Après avoir cloner le projet git et s'être placer à la racine du projet, on peut construire l'image docker avec `docker-compose build` et lancer le container avec `docker-compose up`.

Avec un browser on peut accéder au site avec l'addresse ip de la machine cameraclub sur le port 81. Pour obtenir l'adresse ip `docker-machine ip cameraclub`, par ex. 192.168.64.10, on accèdera donc à la page à l'adresse: http://192.168.64.10:81 .

## Technologies

Ce site est basé sur `python-flask` avec un framework HTML5 `twitter-bootstap`. Les javascripts utilisent `sass` et le css `scss`. Le contenu est entré en Markdown grâce au module `Flask-Markdown`.