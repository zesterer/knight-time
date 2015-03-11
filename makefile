#The name of the program
NAME=knight-time

VALAC=valac
VALA_SOURCES=\
\
src/main.vala \
\
src/core/core.vala \
src/core/piece.vala \
src/core/game.vala \
src/core/board.vala \
src/core/move.vala \
\
src/common/common.vala \

VALA_PACKAGES=--pkg gtk+-3.0 -X -lm -X -g -X -fsanitize=address

default: build

build: $(VALA_SOURCES)
	@echo "Building..."
	@$(VALAC) -o $(NAME) $(VALA_PACKAGES) $(VALA_SOURCES)
	@echo "Built."

install: $(NAME)
	@echo "Adding runnable flag to executable file..."
	@chmod +x $(NAME)
	@echo "Moving to install directory..."
	@sudo mv $(NAME) /usr/bin/$(NAME)
	@echo "Moved."

run: $(NAME)
	@echo "Running..."
	@./$(NAME)

buildrun:
	@make build
	@make run

help:
	@echo "To compile, run 'make build'"
	@echo "To install, run 'sudo make install'"
