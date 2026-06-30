COMMAND_NAME = server-stat
INSTALL_DIRECTORY = /usr/local/bin

install:
	@echo "Installation $(COMMAND_NAME) in $(INSTALL_DIRECTORY)..."
	sudo cp server-stat.sh $(INSTAll_DIRECTORY)/$(COMMAND_NAME)
	sudo chmod +x $(INSTAll_DIRECTORY)/$(COMMAND_NAME)
	@echo "Success! You can now run '$(COMMAND_NAME)' from anywhere."

uninstall:
	@echo "Removing ${COMMAND_NAME} from ${INSTALL_DIRECTORY}..."
	sudo rm -f ${INSTALL_DIRECTORY}/$(COMMAND_NAME)
	@echo "Success."
