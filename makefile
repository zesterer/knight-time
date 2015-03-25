#The name of the program
NAME=knightmare

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
src/common/dynamiclist.vala \
src/common/parser.vala \
\
src/ui/ui.vala \
src/ui/window.vala \
src/ui/boardarea.vala \
src/ui/headerbar.vala \
src/ui/actionbar.vala \

VALA_PACKAGES=--pkg gtk+-3.0 -X -lm \

VALA_ADDITIONAL=--vapidir=vapi -X -g -X -fsanitize=address

LINES_VALA=`( find src -name '*.vala' -print0 | xargs -0 cat ) | wc -l`

default: build

build: $(VALA_SOURCES)
	@echo "Building..."
	@$(VALAC) -o $(NAME) $(VALA_PACKAGES) $(VALA_ADDITIONAL) $(VALA_SOURCES)
	@echo "Built."
	@echo "Info: There are $(LINES_VALA) lines of Vala code"

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
