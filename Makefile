COMMAND_NAME = server-stat
INSTALL_DIR = /usr/local/bin

install:
	@echo "Installation $(COMMAND_NAME) to $(INSTALL_DIR)..."
	sudo cp server-stat.sh $(INSTALL_DIR)/$(COMMAND_NAME)
	sudo chmod +x $(INSTALL_DIR)/$(COMMAND_NAME)
	@echo "Success! Now you can run '$(COMMAND_NAME)' from anywhere."

uninstall:
	@echo "Removing ${COMMAND_NAME} from ${INSTALL_DIR}..."
	sudo rm -f $(INSTALL_DIR)/$(COMMAND_NAME)
	@echo "Success."
