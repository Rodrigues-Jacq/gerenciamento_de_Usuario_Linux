#!/bin/bash

while true
do
	echo =================== Gerenciamento de Usuários ===========================
	echo 1- Adicionar usuário
	echo 2- Remover usuário
	echo 3- Renomear usuário
	echo 4- Alteração de senha do usuário
	echo 0- Sair
	echo
	read -p "Escolha: " ESCOLHA
	case $ESCOLHA in
		1)
			echo
			read -p "Informe o nome do novo usuário: " USER
			if id $USER >/dev/null
			then
				echo
				echo O usuário $USER já existe no sistema, valide e tente novamente...
			else
				echo
				adduser $USER
			fi
			;;
		2)
			echo
			read -p "Informe o nome do usuário a ser removido: " USER
			if id $USER >/dev/null
			then
				echo
				userdel -r $USER >/dev/null
				rm -rf /home/$USER

			else
				echo
				echo O usuário $USER não existe para ser removido, valide e tente novamente...
			fi
			;;
		3)
			echo
			read -p "Informe o nome do usuário a ser renomeado: " USER
			if id "$USER" >/dev/null
			then
				echo
				read -p "Informe o nome novo nome para $USER: " RENOMEIA
				usermod -l $RENOMEIA $USER
				mv /home/$USER /home/$RENOMEIA
				echo
				echo Pelo usuário $USER obter um novo nome como $RENOMEIA, será necessário alterar a senha para o mesmo. Informe a nova senha abaixo:
				passwd $RENOMEIA
			else
				echo
				echo O usuário $USER informado não foi encontrado no sistema para ser renomeado, valide e tente novamente...
			fi
			;;
		4)
			echo
			read -p "Informe o nome do usuário: " USER
			if id "$USER" >/dev/null
			then
				echo
				passwd $USER
			else
				echo
				echo O usuário $USER não foi encontrado no sistema, valide e tente novamente...
			fi
			;;
		0)
			echo
			echo Saindo
			exit 0
			;;
		*)
			echo
			echo Opção inválida, tente novamente...
			;;
	esac

done
