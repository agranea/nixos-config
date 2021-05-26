.PHONY: update
update:
	ansible-playbook update.yml -i ${HOST},
