FROM inutil/whingo:latest

# Instala bash, curl y jq
RUN apk add --no-cache bash curl jq

# Copia el contenido de rootfs al sistema de archivos de la imagen
COPY rootfs/ /

# Permisos de ejecución para el script de arranque
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]

# This Dockerfile is intentionally left blank.
# The add-on uses the pre-built image inutil/whingo:latest as defined in config.json. 