# Image Docker pour les CTFs

Cette image Docker est spécialement conçue pour être utilisée lors de compétitions Capture The Flag (CTF) ou pentest.

## Utilisation

Pour utiliser cette image Docker, vous pouvez exécuter la commande suivante :

```bash
  docker build -t successfulkali .
```

Puis 

```bash
  docker run --privileged -it --name nom_conteneur successfulkali /bin/bash
```

Revenir sur le docker 

```
docker exec -it nom_conteneur /bin/bash
```