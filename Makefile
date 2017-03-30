VERSION  := $(shell cat server/VERSION)
VOLUME   := factorio_savegame

VOLUME_EXISTS := $(shell docker volume ls | grep ${VOLUME})

ifeq ("${VOLUME_EXISTS}","")
	VOLUME_DEP := volume
else
	VOLUME_DEP :=
endif



build:
	@echo Building the image
	@docker build -t dentych/factorio:${VERSION} .

volume: 
	@echo Creating volume:
	@docker volume create --name ${VOLUME}

run: ${VOLUME_DEP}
	@docker-compose up -d

stop:
	@docker-compose down

remove: stop
	@echo Removing volume
	@docker volume rm ${VOLUME}
