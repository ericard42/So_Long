# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ericard <ericard@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/10/04 09:13:57 by ericard           #+#    #+#              #
#    Updated: 2021/10/04 09:14:40 by ericard          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRCS	=	so_long.c \
			
NAME	=	so_longs

OBJ_DIR =	objs
SRC_DIR =	srcs
INCLUDE	=	include
MLX_DIR =	minilibx-linux

OBJ	=	$(addprefix $(OBJ_DIR)/,$(SRCS:.c=.o))

RM		=	rm -rf

CC		=	clang

CFLAGS	=	-Wall -Werror -Wextra -g -fsanitize=address

.c.o:	
			$(CC) $(CFLAGS) -c $< -o $(<:.c=.o)
			

all:		$(NAME)

$(NAME):	$(OBJ)
			@cd minilibx-linux && make
			$(CC) $(CFLAGS) -o $(NAME) $(OBJ) -L $(MLX_DIR) -lmlx -lm -lbsd -lX11 -lXext

$(OBJ_DIR)/%.o:	$(SRC_DIR)/%.c
				@mkdir -p $(OBJ_DIR)
				$(CC) $(CFLAGS) -I $(INCLUDE) -I $(MLX_DIR) -c $< -o $@
				@printf "\e[1A\e[0K"

clean:
			$(RM) $(OBJ_DIR)

fclean:		clean
			@cd minilibx-linux && make clean
			$(RM) $(NAME)

re:			fclean all

.PHONY: all clean fclean re