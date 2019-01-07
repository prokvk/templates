COMMON_NAME = image_name

IMAGE = $(COMMON_NAME)
NAME = $(COMMON_NAME)

# --user root
# -v $$PWD/app:/usr/src/app
# -p 80:80
# -e "ENVVAR=1"
# --link="mysql:mysql.ccl"
# PARAMS = -p 80:80

.PHONY: build run rund runsh stop inspect logs

build:
		docker build -t $(IMAGE) .

run:
		docker run --rm -it --name $(NAME) $(PARAMS) $(IMAGE)

rund:
		docker run -d --name $(NAME) $(PARAMS) $(IMAGE)

runsh:
		docker run --rm -it --name $(NAME) $(PARAMS) $(IMAGE) bash

stop:
		docker stop $(NAME)
		docker rm $(NAME)

inspect:
		docker exec -it $(NAME) bash

logs:
		docker logs $(NAME)