#!/bin/bash

if [ "$AWS_CREDENTIALS_PATH" == "" ]; then
	echo "ERROR: Required variable AWS_CREDENTIALS_PATH missing" && exit 1
fi

if [ "$TF_CMD" != "" ]; then
	if [ "$TF_CMD" == 'apply' ] || [ "$TF_CMD" == 'destroy' ]; then
		AUTO_APPROVE="-auto-approve"
	fi

	CONTAINER_CMD="terraform ${TF_CMD} ${AUTO_APPROVE}"
else
	echo "ERROR: Unknown command" && exit 1
fi

CMD="docker run --rm -it \
	-v ${PWD}:/_src \
	-v ${AWS_CREDENTIALS_PATH}:/root/.aws/credentials \
	-w /_src/terraform \
	terraform bash -c \"${CONTAINER_CMD}\""

echo ${CMD}
eval ${CMD}

exit $?
