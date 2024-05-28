# Image Docker pour les CTFs

Cette image Docker est spécialement conçue pour être utilisée lors de compétitions Capture The Flag (CTF) ou pentest.

## Utilisation

Pour utiliser cette image Docker, vous pouvez exécuter la commande suivante :
bash```
docker build -t <nomdelimage> .
````

Puis
bash```
docker run --privileged -it --name nom_conteneur <votre_image> /bin/bash
```
