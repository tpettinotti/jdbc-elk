# DETERMINE PLATFORM
ifeq (Darwin, $(findstring Darwin, $(shell uname)))
  PLATFORM := OSX
else
  PLATFORM := Linux
endif

# If the first argument is one of the supported commands...
SUPPORTED_COMMANDS := start stop restart state sh
SUPPORTS_MAKE_ARGS := $(findstring $(firstword $(MAKECMDGOALS)), $(SUPPORTED_COMMANDS))
ifneq "$(SUPPORTS_MAKE_ARGS)" ""
  # use the rest as arguments for the command
  COMMAND_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  COMMAND_ARGS := $(subst :,\:,$(COMMAND_ARGS))
  # ...and turn them into do-nothing targets
  $(eval $(COMMAND_ARGS):;@:)
endif

# Project vars
step=-----------------------
project=elk-data
projectCompose=elk-data
composeFile=docker-compose.yml
compose = docker-compose -f $(composeFile) -p $(projectCompose)

# HELP MENU
all: help
help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1.  make requirements         - Install requirements"
	@echo ""

# MANAGE
build: remove
	@echo "$(step) Building images docker $(step)"
	@$(compose) build

# MANAGE
build-no-cache: remove
	@echo "$(step) Building images docker $(step)"
	@$(compose) build --no-cache

up:
	@echo "$(step) Starting $(project) $(step)"
	@$(compose) up -d elk

start: up

stop:
	@echo "$(step) Stopping $(project) $(step)"
	@$(compose) stop

restart: stop start

state:
	@echo "$(step) Etat $(project) $(step)"
	@$(compose) ps

remove: stop
	@echo "$(step) Remove $(project) $(step)"
	@$(compose) rm --force

bash:
	@echo "$(step) Bash $(project) $(step)"
	@$(compose) run --rm elk bash