; ||#################################################||
; ||# 												#||
; ||#		  	Instituto Superior Técnico			#||
; ||# 												#||
; ||#################################################||
; ||#												#||
; ||#				|	Carolina Neves - 82527		#||
; ||# 	- Grupo 7 -	|	João Carlos - 82528			#||
; ||#  				| 	João Bernardo - 82547 		#||
; ||#												#||
; ||#################################################||

; |------------|
; | Constantes |
; |------------|----------------------------------------------------------------------------------------|
												; 														|
perifEntrada		EQU		0E000H				; Endereço do periferico de entrada (Relógios que ligam	|
												; às interrupções e teclado) 							|
perifSaida_1 		EQU 	0A000H				; Endereço para a pontuação 							|
perifSaida_2		EQU		0C000H				; Leitura do teclado 									|
pixelScreenIn		EQU 	08000H 				; Primeiro endereço do Pixel Screen						|
pixelScreenOut	 	EQU 	0807FH 				; Último endereço do Pixel Screen 						|
mascaraMissil 		EQU 	0E0H 				; Máscara para a tecla de lançar um míssil 				|
mascaraRecom 		EQU 	0E1H 				; Recomeça o Jogo 										|
mascaraAcaba		EQU 	0E2H 				; Pausa o Jogo 											|
												; 														|
canhaoAlt 			EQU		02H 				; Altura do Canhão 										|
canhaoComp 			EQU 	10H 				; Máscara para o Canhão 								|
explosaoAlt 		EQU		04H					; Altura da Explosão									|
explosaoComp 		EQU 	08H					; Máscara para a Explosão 								|
aviaoAlt 			EQU		05H					; Altura do Avião										|
aviaoComp 			EQU 	08H 				; Máscara para o Avião									|
cartuchoAlt			EQU		02H					; Altura do Cartucho									|
cartuchoComp		EQU 	10H 				; Máscara para o Cartucho 								|
												;														|
limCanhaoEsq		EQU 	0 					; Limite esquerdo do Canhão 							|
limCanhaoDir 		EQU 	27 					; Limite direito do Canhão 								|
limCanhaoCima		EQU 	22					; Limite cima do Canhão 								|
limCanhaoBaixo		EQU 	30 					; Limite baixo do Canhão 								|
limAviaoEsq 		EQU 	0 					; Limite esquerdo do avião 								|
limAviaoDir 		EQU 	28 					; Limite direito do Avião, onde começa 					|
												;														|
numAvioes 			EQU 	03H					; Número máximo de aviões 								|
numCartuchos 		EQU  	01H 				; Número máximo de cartuchos 							|
numeroMisseis 		EQU 	05H 					; Número máximo de mísseis 								|
												;														|
linhaPixel 			EQU 	01H 				; Local de onde sai o Pixel de acordo com o Canhão		|
colunaPixel 		EQU 	02H 				;														|
												;														|
iniciaCartuchoL		EQU 	1					; Linha onde se começa a escrever o Cartucho			|
iniciaCartuchoC 	EQU 	15 					; Coluna onde se começa a escrever o Cartucho			|
iniciaAviao1L 		EQU 	5					; Linha onde se começa a escrever o Avião 1				|
iniciaAviao1C 		EQU 	5					; Coluna onde se começa a escrever o Avião 1 			|
iniciaAviao2L 		EQU 	15 					; Linha onde se começa a escrever o Avião 2				|
iniciaAviao2C 		EQU 	13					; Coluna onde se começa a escrever o Avião 2 			|
iniciaAviao3L 		EQU 	10					; Linha onde se começa a escrever o Avião 3 			|
iniciaAviao3C 		EQU 	24 					; Coluna onde se começa a escrever o Avião 3 			|
												;														|
aviaoLinhas 		EQU 	2AH					; Número máximo de linhas que os aviões podem variar 	|
cartuchoColunas		EQU 	3EH					; Número máximo de colunas que o cartucho pode variar 	|
cartuchoTime 		EQU 	0AH 				; Limite de Interrupções para que o cartucho se possa 	|
												; mover novamente 										|
numPixeisAviao 		EQU 	0AH					; Número de pixeis do Avião 							|
numPixeisCartu 		EQU 	03H 				; Número de pixeis do Cartucho 							|
												;														|
; |-----------------------------------------------------------------------------------------------------|

; |-----------|
; |	Variáveis |		
; |-----------|-----------------------------------------------------------------------------------------|
												; 														|
PLACE 1000H										; 														|
												;														|
valorpontuacao: 	WORD 	0 					;														|
												; 														|
aTecla: 			WORD 	10H					; Local onde a tecla premida é guardada  	   			|
												;														|
valorInterrup1: 	WORD 	0 					; Local da memória onde se sabe se a Interrupção 1 já 	|
												; ocorreu ou não							   			|
valorInterrup2: 	WORD 	0 					; Local da memória onde se sabe se a Interrupção 2 já 	|
												; ocorreu ou não							   			|
drawAviao:			STRING 	04H					; Desenho do Avião										| -> Dava para escever e apagar só os pixeis pretendidos, como para as colisões
					STRING 	05H					; 						  					   			|
					STRING 	0FH					; 										  	   			|
					STRING 	05H					; 						  								|
					STRING 	04H					; 						  								|
												; 														|
drawCanhao: 		STRING 0AH 					; Desenho do Canhão  									|
					STRING 1FH					; 							   							|
												;														|
drawExplosao:		STRING 09H					; Desenho da Explosao  									|
					STRING 06H					;								 	    				|
					STRING 06H					;								 						|
					STRING 09H					; 									   					|
												; 														|
drawCartucho:		STRING 1FH					; Desenho do Cartucho 									|
					STRING 11H					; 							  							|
												; 														|
stringPixel: 		STRING 080H					; Máscara para acender/apagar pixeis					|
					STRING 040H					; 														|
					STRING 020H 				;														|
					STRING 010H 				;														|
					STRING 008H 				;														|
					STRING 004H 				;														|
					STRING 002H					;														|
					STRING 001H 				;														|
												; 														|
tabTeclado:			WORD	-1					; Tecla 0, linha      - Canhão anda para cima e para 	|
					WORD 	-1 					; Tecla 0, coluna       a esquerda						|
					WORD 	-1 					; Tecla 1, linha	  -	Canhão anda para cima			|
					WORD 	0					; Tecla 1, coluna										|
					WORD 	-1					; Tecla 2, linha	  - Canhão anda para cima e para	|
					WORD	1					; Tecla 2, coluna		a direita						|
					WORD 	0 					; Tecla 3, linha   	  - Tecla Vazia						|
					WORD 	0					; Tecla 3, coluna 										|
					WORD	0					; Tecla 4, linha	  - Canhão anda para a esquerda		|
					WORD	-1					; Tecla 4, coluna										|
					WORD 	mascaraMissil		; Tecla 5, linha 	  - Tecla que dispara Mísseis		|
					WORD 	mascaraMissil		; Tecla 5, coluna 										|
					WORD	0 					; Tecla 6, linha	  - Canhão anda para a direita		|
					WORD	1					; Tecla 6, coluna										|
					WORD 	0					; Tecla 7, linha 	  - Tecla Vazia  					|
					WORD 	0					; Tecla 7, coluna 										|
					WORD	1					; Tecla 8, linha	  - Canhão anda para baixo e para	|
					WORD	-1					; Tecla 8, coluna		a esqueda						|
					WORD	1					; Tecla 9, linha	  - Canhão anda para baixo			|
					WORD	0					; Tecla 9, coluna										|
					WORD	1					; Tecla A, linha	  - Canhão anda para baixo e para	|
					WORD	1					; Tecla A, coluna 		a direita						|
					WORD 	0					; Tecla B, linha 	  - Tecla Vazia  					|
					WORD 	0					; Tecla B, coluna 										|
					WORD 	0					; Tecla C, linha 	  - Tecla Vazia 					|
					WORD 	0					; Tecla C, coluna 										|
					WORD 	0					; Tecla D, linha 	  - Tecla Vazia  					|
					WORD 	0					; Tecla D, coluna										|
					WORD 	mascaraRecom		; Tecla E, linha 	  - Tecla para recomeçar o Jogo 	|
					WORD 	mascaraRecom 		; Tecla E, coluna										|
					WORD 	mascaraAcaba		; Tecla F, linha 	  - Tecla para pausar o Jogo 		|
					WORD 	mascaraAcaba		; Tecla F, coluna 										|
												; 														|
coordenCanhao: 		WORD 	30					; Valor da linha do Canhão 								|
					WORD 	13					; Valor da coluna do Canhão 							|
												;														|
coordenAviao:		WORD 	10					; Valor da linha do Avião 3 							|
					WORD 	24					; Valor da coluna do Avião 3 							|
					WORD 	15					; Valor da linha do Avião 2								|
					WORD 	13					; Valor da coluna do Avião 2 							|
			 		WORD 	05					; Valor da linha do Avião 1								|
					WORD 	05					; Valor da coluna do Avião 1							|
												;														|
coordenCartucho: 	WORD 	1 					; Valor da linha do Cartucho 							|
					WORD 	15					; Valor da coluna do Cartucho 							|
												; 														|
;numeroMisseis: 		WORD 	5					; Número de mísseis disponíveis							|
coordenMissil: 		WORD 	0					; Valor da linha do Míssil 1	 						|
					WORD	0					; Valor da coluna do Míssil 1							|
					WORD 	0					; Valor da linha do Míssil 2							|
					WORD  	0					; Valor da coluna do Míssil 2 							|
					WORD 	0					; Valor da linha do Míssil 3	 						|
					WORD	0					; Valor da coluna do Míssil 3							|
					WORD 	0					; Valor da linha do Míssil 4							|
					WORD  	0					; Valor da coluna do Míssil 4 							|
					WORD 	0					; Valor da linha do Míssil 5	 						|
					WORD	0					; Valor da coluna do Míssil 5							|
					WORD 	0					; Valor da linha do Míssil 6							|
					WORD  	0					; Valor da coluna do Míssil 6 							|
					WORD 	0					; Valor da linha do Míssil 7	 						|
					WORD	0					; Valor da coluna do Míssil 7							|
					WORD 	0					; Valor da linha do Míssil 8							|
					WORD  	0					; Valor da coluna do Míssil 8 							|
					WORD 	0					; Valor da linha do Míssil 9	 						|
					WORD	0					; Valor da coluna do Míssil 9							|
												; 														|
aviaoNumAleaX: 		WORD 	0 					; Variável para número aleatório do da linha dos aviões	|
aviaoNumAlea: 		WORD 	7 					; Números aleatórios para o valor da linha dos Aviões 	|
					WORD 	14					;														|
					WORD 	11					;														|
					WORD 	6					;														|
					WORD	7					;														|
					WORD 	10					;														|
					WORD 	9					;														|
					WORD 	5					;														|
					WORD 	14					;														|
					WORD 	15					;														|
					WORD 	10					;														|
					WORD 	9					; 													 	|
					WORD 	12					;														|
					WORD 	12					;														|
					WORD 	6					;														|
					WORD	15					;														|
					WORD 	13					;														|
					WORD 	8					;														|
					WORD 	11					;														|
					WORD 	5					;														|
					WORD 	8					;														|
					WORD 	13					;														|
												;														|
cartuchoConta: 		WORD 	0 					; Contador para o Cartucho se poder mover novamente 	|
cartuchoNumAleaX: 	WORD 	0 					; Variável para número aleatório do da linha do cartucho|
cartuchoNumAlea:	WORD 	24					; Números aleatórios para o valor da linha do cartucho 	|
					WORD 	11					;														|
					WORD 	15					;														|
					WORD	3					;														|
					WORD	20					;														|
					WORD 	6					;														|
					WORD 	12					;														|
					WORD	23					;														|
					WORD	2					;														|
					WORD	13					;														|
					WORD	0					;														|
					WORD	26					;														|
					WORD	19					;														|
					WORD	5					;														|
					WORD	14					;														|
					WORD	9					;														|
					WORD	10					;														|
					WORD	27					;														|
					WORD	22					;														|
					WORD	1					;														|
					WORD	18					;														|
					WORD	17					;														|
					WORD	25					;														|
					WORD	4					;														|
					WORD	7					;														|
					WORD	21					;														|
					WORD	8					;														|
					WORD	16					;														|
												;														|
colisaoAviao: 		WORD 	2					; Valores a somar à coordenada de referência do avião 	|
					WORD 	0 					; para averiguar se uma das balas o atingiu 			|
					WORD 	0 					;														|
					WORD 	1 					;														|
					WORD 	1					;														|
					WORD 	1					;														|
					WORD 	2 					; 														|
					WORD 	1 					;														|
					WORD 	3 					;														|
					WORD 	1					;														|
					WORD 	4					;														|
					WORD 	1 					; 														|
					WORD 	2 					;														|
					WORD 	2 					;														|
					WORD 	1					;														|
					WORD 	3					;														|
					WORD 	2 					; 														|
					WORD 	3 					;														|
					WORD 	3 					;														|
					WORD 	3					;														|
												;														|
colisaoCartu: 		WORD 	1 					; Valores a somar à corrdenada de referência do cartucho|
					WORD 	1					; para averiguar se uma das balas o atingiu 			|
					WORD 	1					;														|
					WORD	2					;														|
					WORD	1					;														|
					WORD	3					;														|
												;														|
; |-----------------------------------------------------------------------------------------------------|

; |---------------|
; | Stack Pointer |
; |---------------|-------------------------------------------------------------------------------------|
												; 														|
PLACE 1300H										;	 													|
												; 														|
inicioPilha: 		TABLE 	200H				; Espaço reservado para o Stack Pointer					|
fimPilha: 										; 														|
												; 														|
; |-----------------------------------------------------------------------------------------------------|

; |------------------------|
; | Tabela de Interrupções |
; |------------------------|----------------------------------------------------------------------------|
												; 														|
PLACE 1500H										;	 													|
												; 														|
tabInterrup: 		WORD 	interrupcao1		; Interrupção que move as balas							|
					WORD 	interrupcao2 		; Interrupção que move os aviões e o cartucho			|
												; 														|
; |-----------------------------------------------------------------------------------------------------|

; |--------------------|
; | Programa Principal |
; |--------------------|--------------------------------------------------------------------------------|
												;													 	|
PLACE 0											; 														|
												; 														|
letGameBegin:		MOV 	BTE, tabInterrup 	; 														|
					MOV 	SP, fimPilha		; 														|
					CALL 	inicializaGame		; Prepara o Jogo para que possa iniciar 				|
					EI0 						; Ativa a interrupção que faz as balas movimentarem-se	|
					EI1 						; Ativa a interrupção que faz os objetos movimentarem-se|
					EI 							; Ativa todas as interrupções							|
												;														|
inicio:				CALL 	leTeclado			; Lê a tecla que é premida 								|
					CALL 	moveObjetos			; Faz mover o avião caso a interrupção esteja ligada 	|
					JMP 	inicio 				; Volta a repetir estes passos 							|
												;														|
letGameEnd:			DI 							; Desliga as Interrupções 								|
					JMP 	letGameEnd 			; Fim do Jogo											|
												; 														|
; |-----------------------------------------------------------------------------------------------------|


; |#####################################################################################################||
; |-----------------------------------------------------------------------------------------------------||
; | Função: Inicializa Jogo																				||
; | Descrição: Prepara o Jogo de maneira a que posso iniciar 											||
; |-----------------------------------------------------------------------------------------------------||
												; 														||
inicializaGame:		CALL 	limpaEcran 			; Chama a rotinha que vai limpar o ecrãn 				||
					CALL 	inicializaPontos	; Coloca a pontuação a zero 							||
					CALL 	escreveCanhao 		; Escreve o Canhão inicial 								||
					CALL 	inicializaAvioes	; Escreve os Aviões iniciais							||
					CALL 	inicializaCartucho 	; Escreve o Cartucho inicial 							||
					CALL  	inicializaMisseis 	; Coloca todos os mísseis prontos a serem disparados 	||
												;														||
					RET 						;														||
												; 														||
; |-----------------------------------------------------------------------------------------------------||
; |#####################################################################################################||


; |#####################################################################################################||
; |-----------------------------------------------------------------------------------------------------||
; | Função: Apaga Ecrãn 																				||
; | Descrição: Apaga o ecrã para se poder iniciar o jogo 												||
; |-----------------------------------------------------------------------------------------------------||
												; 														||
limpaEcran:			MOV 	R1, 00H 	 		; 														||
					MOV 	R2, pixelScreenIn 	; Primeiro endereço do Pixel Screen 					||
					MOV 	R3, pixelScreenOut 	; Último endereço do Pixel Screen 						||
												; 														||
ciclo22:	 		MOV 	[R2], R1			; Colocar o endereço a zero								||
					ADD 	R2, 2				; Próximo endereço 										||
					CMP 	R3, R2				; Verificar se chegou ao último endereço 				||
					JGE 	ciclo22 			; Volta a fazer tudo, mas no endereço seguinte 			||
												; 														||
					RET 						; 														||
												; 														||
; |-----------------------------------------------------------------------------------------------------||
; |#####################################################################################################||


; |#####################################################################################################||
; |-----------------------------------------------------------------------------------------------------||
; | Função: leTeclado																					||
; | Descrição: Lê uma linha do teclado e verifica se alguma linha foi premida (caso não tenha sido		||
; |			   premida alguma tecla dessa linha, passa à linha seguinte.								||
; |-----------------------------------------------------------------------------------------------------||
												; 														||
leTeclado:			MOV		R1, perifEntrada	; Endereço do Periférico de Entrada 					||
					MOV		R2, perifSaida_2	; Endereço do Periférico de Saída 	     				||
					MOV 	R4, 08H				; Última linha para ser testada							||
					MOV 	R5, 08H				; Última coluna para ser verificada 					||
					MOV 	R6, 00H			 	; 														||
					MOV 	R7, 00H				; 														||
					MOV 	R8, 0FH				; Máscara para aplicar no Periférico de Entrada			||
					MOV 	R9, aTecla          ; Endereço da memória onde vai ser guardada a tecla 	||
												; 														||
percorreLinha:		MOVB	[R2], R4			; Escrever a linha no Periférico Saída 					||
					MOVB	R3, [R1]			; Ler do Periférico de Entrada 							||
					AND 	R3, R8 				; Isolar os 4 bits referentes aoo teclado				||
					JNZ		qualTecla1 	 		; Uma das teclas foi permida 							||
					SHR		R4, 1				; Linha seguinte 										||
					JNZ		percorreLinha		; Verificar linha acima 								||
					JMP		ciclo11				; Já verificou todas as linhas e nenhuma foi premida 	||
												; 														||
qualTecla1:			SHR		R4, 1				; Transforma a linha em hexadecimal						||
					JZ		qualTecla2			; Caso já tenha convertido passa para a coluna 			||
					ADD		R6, 1				; Guarda o número da linha em hexadecimal				||
					JMP		qualTecla1			; Conversão ainda não concluída							||
												; 														||
qualTecla2:			SHR 	R3, 1				; Transforma a coluna em hexadecimal 					||
					JZ 		qualTecla3			; Caso já tenha convertido passa para a fórmula final	||
					ADD		R7, 1				; Guarda o valor da coluna em hexadecimal				||
					JMP 	qualTecla2 			; Conversão ainda não concluída							||
												; 														||
qualTecla3: 		MOV 	R8, 04H 			; Fórmula -> 4(linha) + coluna							||
					MUL 	R6, R8				; Multiplica o número da linha por 4					||
					ADD		R6, R7				; Soma com o número da coluna							||
					MOV 	[R9], R6			; Guarda o número da tecla em hexadecimal na memória	||
												;														||
					CALL 	qualTecla10	 		; Faz o que a tecla pretende							||
												; 														||
ciclo11:			RET 						; 														||
												;														||
; |-----------------------------------------------------------------------------------------------------||
;																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Qual a Tecla 	 																			||
; | Descrição: Vai saber qual a tecla premida 															||
; |-----------------------------------------------------------------------------------------------------||
												;														||
qualTecla10:		MOV 	R5, aTecla			; Endereço da tecla que foi permida 					||
					MOV 	R5, [R5]			; Valor da tecla que foi premida 						||
					MOV 	R4, 04H				; 														||
					MUL 	R5, R4				; Fórmula para o endereço da tecla premida (tabTeclado) ||
					MOV 	R7, tabTeclado		; 														||
					ADD 	R7, R5				; Endereço da tecla premida (tabTeclado)				||
												;														||
					MOV 	R9, [R7] 			; Primeiro contéudo da tecla premida					||
					ADD 	R7, 2				;														||
					MOV 	R10, [R7]			; Segundo conteúdo da tecla	premida						||
												;														||
					MOV 	R3, mascaraMissil	; Máscaras para saber o que fazer com determinadas		||
					MOV 	R4, mascaraAcaba	; teclas premidas										||
					MOV 	R5, mascaraRecom	;														||
												;														||
					CMP 	R9, R3				; Verifica se a tecla premida é referente ao lançamento	||
					JZ 		lancaMissil0 		; de um Míssil					w						||
					CMP 	R9, R4				; Verifica se a tecla premida é referente ao reinicio	||
					JZ 		letGameEnd0 		; do Jogo												||
					CMP 	R9, R5				; Verifica se a tecla premida é referente ao fim do		||
					JZ 		letGameRestart0		; Jogo													||
					CALL	moveCanhao  		; Move o canhão com o contéudo existente em tabTeclado  ||
					JMP 	qualTeclaFim		;														||
												;														||
lancaMissil0: 		CALL 	lancaMissil 		; Lança o Míssil										||
					JMP 	qualTeclaFim		;														||
letGameRestart0: 	DI 							;														||
					CALL 	inicializaGame 		; Recomeça o Jogo										||
					JMP 	qualTeclaFim		;														||
letGameEnd0: 		CALL 	letGameEnd 			; Acaba o jogo 											||
												;														||
qualTeclaFim:		RET 						;														||
												;														||
; |#####################################################################################################||


; |#####################################################################################################||
; |-----------------------------------------------------------------------------------------------------||
; | Função: Escreve/Apaga Pixel 																		||
; | Descrição: Desenha ou apaga um determinado pixel no ecrãn.											||
; |-----------------------------------------------------------------------------------------------------||
												; 														||
escrevePixel: 		PUSH 	R1					; 														||
					PUSH 	R2					; 														||
					PUSH 	R3					; 														||
												;														||
						PUSH 	R2				; Uma vez que vai ser necessário mais do que uma vez o	||
													; valor da coluna, faço um novo PUSH/POP 			||
						MOV 	R3, pixelScreenIn 	; Fórmula -> 8000 + 4(linha) + coluna//8)			||
						SHL 	R1, 2				; Multiplica a linha por 4							||
						SHR 	R2, 3			; Divisão inteira da coluna por 8						||
						ADD 	R1, R2 			; 														||
						ADD 	R3, R1			; Valor do endereço onde o pixel vai ser aceso/apagado 	||
												; 														||
						POP 	R2				;									 					||
												;														||
					MOV 	R1, 08H 			; 														||
					MOD 	R2, R1				; Bit a acender/apagar (coluna%8)						||
					MOV 	R1, stringPixel 	; Máscara que contém os endereços das colunas			||
					ADD 	R1, R2				; Seleciona o endereço do pixel a acender/apagar 		||
					MOVB 	R1, [R1] 			; Conteúdo do endereço do pixel escolhido 				||
					MOVB 	R2, [R3]			; Conteúdo que está dentro do endereço acima referido	||
					AND 	R0, R0				;														||
					JZ		apagaPixel 			; O bit em questão está aceso, logo vai apagá-lo		||
												; 														||
pintaPixel:			OR 		R2, R1 				; Bit que vai ser aceso 					 			||
					JMP		pixelChanged 		; 														||
												; 														||
apagaPixel: 		NOT 	R1					; Inverte R5 para poder apagar o pixel desejado			||
					AND 	R2, R1				; Apaga o pixel 					 					||
												; 														||
pixelChanged:		MOVB 	[R3], R2			; Escreve o valor atualizado no endereço do pixel		||
												; 														||
					POP 	R3					; 														||
					POP 	R2					; 														||
					POP 	R1					; 														||
					RET 						; 														||
												; 														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Escreve linha 																				||
; | Descrição: Vai desenhar uma linha de um determinado desenho											||
; |-----------------------------------------------------------------------------------------------------||
												;														||
escreveLinha: 		PUSH 	R0					; 														||
					PUSH 	R2					;														||
												; 														||
ciclo33:			PUSH 	R0					; Máscara que contém uma linha dos objetos 				||
					AND 	R0, R5 				; Verificar o valor lógido do bit mais significicativo 	||
					JNZ 	ciclo31 			; O bit desejado tem valor 1 							||
					JMP 	ciclo30		 		; O bit desejado tem valor 0, logo vai escrevê-lo 		||
ciclo31:			MOV 	R0, 01H 			; Vai querer acender o pixel 							||
ciclo30:			CALL 	escrevePixel 		; Vai escrever o pixel 									||
					POP 	R0					; 														||
					ADD 	R2, 1				; Próxima coluna 										||
					SHR 	R0, 1				; Quer verificar o próximo bit 							||
					JNZ 	ciclo33				; Volta a executar enquanto não chegar ao último bit 	||
												; 														||
					POP 	R2					; 														||
					POP		R0 					; 														||
					RET 						;														||
												; 														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Apaga linha 																				||
; | Descrição: Vai apagar uma linha de um determinado desenho											||
; |-----------------------------------------------------------------------------------------------------||
												;														||
apagaLinha: 		PUSH 	R2					; 													 	||
												; 														||
					MOV 	R6, canhaoComp 		; Comprimento máximo do Canhão 							||
												; 														||
ciclo300:			CALL 	escrevePixel 		; Vai apagar o pixel 									||
					ADD 	R2, 1				; Próxima coluna										||
					SHR 	R6, 1				; Quer apagar o próximo bit 							||
					JNZ 	ciclo300			; Volta a executar enquanto não apagar o último bit 	||
												; 														||
					POP 	R2					; 														||
					RET 						;														||
												; 														||
; |-----------------------------------------------------------------------------------------------------||
; |#####################################################################################################||


; -> Ter uma função para inicializar o canhão no início, fazer como para o cartucho


; |#####################################################################################################||
; |-----------------------------------------------------------------------------------------------------||
; | Função: Escreve Canhão 																				||
; | Descrição: Vai desenhar o Canhão nas coordenadas que se indicarem									||
; |-----------------------------------------------------------------------------------------------------||
												; 														||
escreveCanhao: 		MOV 	R0, canhaoComp 		; Máscara para aplicar nas linhas do Canhão 			||
					MOV 	R3, coordenCanhao 	; Endereço das coordenadas do Canhão 					||
					MOV 	R1, [R3]			; Valor da linha onde se começa a desenhar o Canhão 	||
					ADD 	R3,	 2				;														||
					MOV 	R2, [R3]			; Valor da coluna onde se começa a desenhar o Canhão 	||
					MOV 	R7, canhaoAlt 		; Altura máxima do Canhão 								||
					MOV 	R9, 00H 	 		; Valor do endereço de cada Linha do Canhão  			||
												; 														||
cicloCanhao11:		MOV 	R3, drawCanhao 		; Endereço do desenho do Canhão 						||
					ADD 	R3, R9				; Endereço da Linha a desenhar 							||
					MOVB 	R5, [R3]			; Valor da Linha a desenhar 							||
					CALL 	escreveLinha		; Vai desenhar a respetiva linha 						||
												; 														||
					ADD 	R1, 1				; 														||
					ADD 	R9, 1 				; Próxima linha 										||
					CMP 	R7, R9 				; Enquanto R9 não for da altura do Canhão, continua 	||
					JNZ 	cicloCanhao11		; a desenhar o mesmo 									||
												; 														||
					RET 						; 														||
												; 														||
; |-----------------------------------------------------------------------------------------------------||
;																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Apaga Canhão 																				||
; | Descrição: Vai apagar o Canhão nas coordenadas que se indicarem										||
; |-----------------------------------------------------------------------------------------------------||
												; 														||
apagaCanhao: 		PUSH 	R1					; 														||
					PUSH 	R9 					;														||
												; 														||
					MOV 	R0, 00H 	 		; Máscara para apagar os pixeis				 			||
					MOV 	R7, canhaoAlt 		; Altura máxima do Canhão 								||
					MOV 	R9, 00H 	 		; Valor do endereço de cada Linha do Canhão  			||
												;														||
cicloCanhao22:		CALL 	apagaLinha			; Vai apagar a respetiva linha 							||
												; 														||
					ADD 	R1, 1				; 														||
					ADD 	R9, 1 				; Próxima linha 										||
					CMP 	R7, R9 				; Enquanto R9 não for da altura do Canhão, continua 	||
					JNZ 	cicloCanhao22		; a apagar o mesmo 										||
												; 														||
					POP 	R9 					; 														||
					POP 	R1					;														||
					RET 						; 														||
												; 														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Move Canhão 																				||
; | Descrição: Vai mover o Canhão de acordo com a tecla que foi carregada no teclado					||
; |-----------------------------------------------------------------------------------------------------||
												;														||
moveCanhao:			MOV 	R4, coordenCanhao  	; Coordenadas do Canhão 								||
					MOV 	R1, [R4] 			; Valor da linha onde se encontra o canhão				||
					ADD 	R4, 2				;														||
					MOV 	R2, [R4]			; Valor da coluna onde se encontra o canhão				||
					SUB  	R4, 2				;														||
												;														||
					CALL 	apagaCanhao 		; Apaga o Canhão nas antigas coordenadas do ecrá para 	||
												;														||
					CMP 	R9, -1 				; Verifica se o Canhão se movimenta para cima (diagonal)||
					JNZ 	ciclo41				; Não anda no caso anterior logo testa para baixo		||
												;														||
					CMP 	R10, 0				; Verifica se anda para cima 							||
					JZ 		cima00 				; Anda para cima										||
					CMP 	R10, 1				; Verifica se anda para cima e para a direita 			||
					JZ 		cimaDireita00 		; Anda para cima e para a direita 						||
					CALL 	canhaoCimaEsq 		; Move-se para cima e para a esquerda 					||
					JMP 	ciclo44Fim			; Já se moveu											||
												;														||
cima00: 			CALL 	canhaoCima 			; Move-se para cima 									||
					JMP 	ciclo44Fim			; Já se moveu											||
cimaDireita00: 		CALL 	canhaoCimaDir 		; Move-se para cima e para a direita 					||
					JMP 	ciclo44Fim			; Já se moveu											||
												;														||
ciclo41: 			CMP 	R9, 1				; Verifica se o Canhão se move para baixo (diagonal)	||
					JNZ		ciclo40 			; Não anda no caso anterior logo testa para os lados	||
												;														||
					CMP 	R10, 0				; Verifica se anda para baixo 							||
					JZ 		baixo00 			; Anda para baixo										||
					CMP 	R10, 1 				; Verifica se anda para baixo e para direita 			||
					JZ 		baixoDireita00 		; Anda para baixo e para a direita 						||
					CALL 	canhaoBaixoEsq 		; Move-se para baixo e para a esquerda 					||
					JMP 	ciclo44Fim			; Já se moveu											||
												;														||
baixo00: 			CALL 	canhaoBaixo 		; Move-se para baixo 									||
					JMP 	ciclo44Fim			; Já se moveu											||
baixoDireita00: 	CALL 	canhaoBaixoDir 		; Move-se para baixo e para a direita 					||
					JMP 	ciclo44Fim			; Já se moveu											||
												;														||
ciclo40: 			CMP 	R10, -1				; Verifica se anda para esquerda 						||
					JZ 		esquerda00 			; Anda para a esquerda									||
					CMP 	R10, 1 				; Verifica se anda para a direita 						||
					JZ 		direita00 			; Anda para a direita									||
					JMP  	ciclo44Fim			; Já se moveu											||
												;														||
esquerda00: 		CALL 	canhaoEsquerda 		; Move o Canhão para a esquerda 						||
					JMP 	ciclo44Fim			; Já se moveu											||
direita00: 			CALL 	canhaoDireita		; Move o Canhão para a direita 							||
												;														||
ciclo44Fim:			CALL 	escreveCanhao 		; Escreve o Canhão nas novas coordenadas 				||
												; 														||
					RET 						;														||
												;														||
;-------------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Move Canhão Cima																			||
; | Descrição: Vai mover o Canhão para cima 															||
; |-----------------------------------------------------------------------------------------------------||
												;														||
canhaoCima: 		MOV 	R6, limCanhaoCima 	; Limite superior para o Canhão 						||
					CMP 	R1, R6 				; Verifica se o Canhão já está o mais acima possível 	||
					JZ 		canhaoCimaFim 		; Não se pode mover 									||
					ADD 	R1, R9 				; Valor da linha para onde vai o canhão					||
					ADD 	R2, R10				; Valor da coluna para onde vai o canhão				||
					MOV 	[R4], R1 			; Guarda na memória as novas coordenadas do canhão		||
					ADD 	R4, 2				;														||
					MOV 	[R4], R2			;														||
												; 														||
canhaoCimaFim:		RET 						;														||
												;														||
;-------------------------------------------------------------------------------------------------------||
;																										||
; |-----------------------------------------------------------------------------------------------------||
; | Função: Move Canhão Cima Direita 																	||
; | Descrição: Vai mover o Canhão para cima e para a Direita											||
; |-----------------------------------------------------------------------------------------------------||
												;														||
canhaoCimaDir: 		MOV 	R6, limCanhaoCima 	; Limite superior para o canhão 						||
					MOV 	R7, limCanhaoDir 	; Limite direito para o canhão 							||
					CMP 	R1, R6 				; Verifica se o Canhão já está o mais acima possível 	||
					JZ 		canhaoCimaDirFim 	; Não se pode mover										||
					CMP 	R2, R7 				; Verifica se o Canhão já está o mais à direita possível||
					JZ 		canhaoCimaDirFim 	; Não se pode mover										||
					ADD 	R1, R9 				; Valor da linha para onde vai o canhão					||
					ADD 	R2, R10				; Valor da coluna para onde vai o canhão				||
					MOV 	[R4], R1 			; Guarda na memória as novas coordenadas do canhão		||
					ADD 	R4, 2				;														||
					MOV 	[R4], R2			;														||
												; 														||
canhaoCimaDirFim:	RET 						;														||
												;														||
;-------------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Move Canhão Cima Esquerda 																	||
; | Descrição: Vai mover o Canhão para cima e para a Esquerda											||
; |-----------------------------------------------------------------------------------------------------||
												;														||
canhaoCimaEsq: 		MOV 	R6, limCanhaoCima 	; Limite superior para o canhão 						||
					MOV 	R7, limCanhaoEsq 	; Limite esquerdo para o canhão 						||
					CMP 	R1, R6 				; Verifica se o Canhão já está o mais acima possível 	||
					JZ 		canhaoCimaEsqFim 	; Não se pode mover										||
					CMP 	R2, R7 				; Verifica se o Canhão já está o mais à direita possível||
					JZ 		canhaoCimaEsqFim 	; Não se pode mover 									||
					ADD 	R1, R9 				; Valor da linha para onde vai o canhão					||
					ADD 	R2, R10				; Valor da coluna para onde vai o canhão				||
					MOV 	[R4], R1 			; Guarda na memória as novas coordenadas do canhão		||
					ADD 	R4, 2				;														||
					MOV 	[R4], R2			;														||
												; 														||
canhaoCimaEsqFim:	RET 						;														||
												;														||
;-------------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Move Canhão Baixo 		 																	||
; | Descrição: Vai mover o Canhão para baixo 															||
; |-----------------------------------------------------------------------------------------------------||
												;														||
canhaoBaixo: 		MOV 	R6, limCanhaoBaixo 	; Limite inferior para o Canhão 						||
					CMP 	R1, R6 				; Verifica se o Canhão já está o mais abaixo possível 	||
					JZ 		canhaoBaixoFim 		; Não se pode mover										||
					ADD 	R1, R9 				; Valor da linha para onde vai o canhão					||
					ADD 	R2, R10				; Valor da coluna para onde vai o canhão				||
					MOV 	[R4], R1 			; Guarda na memória as novas coordenadas do canhão		||
					ADD 	R4, 2				;														||
					MOV 	[R4], R2			;														||
												; 														||
canhaoBaixoFim:		RET 						;														||
												;														||
;-------------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Move Canhão Baixo Direita 																	||
; | Descrição: Vai mover o Canhão para baixo e para a Direita											||
; |-----------------------------------------------------------------------------------------------------||
												;														||
canhaoBaixoDir:		MOV 	R6, limCanhaoBaixo 	; Limite superior para o canhão 						||
					MOV 	R7, limCanhaoDir 	; Limite direito para o canhão 							||
					CMP 	R1, R6 				; Verifica se o Canhão já está o mais acima possível 	||
					JZ 		canhaoBaixoDirFim 	; Não se pode mover										||
					CMP 	R2, R7 				; Verifica se o Canhão já está o mais à direita possível||
					JZ 		canhaoBaixoDirFim 	; Não se pode mover										||
					ADD 	R1, R9 				; Valor da linha para onde vai o canhão					||
					ADD 	R2, R10				; Valor da coluna para onde vai o canhão				||
					MOV 	[R4], R1 			; Guarda na memória as novas coordenadas do canhão		||
					ADD 	R4, 2				;														||
					MOV 	[R4], R2			;														||
												; 														||
canhaoBaixoDirFim:	RET 						;														||
												;														||
;-------------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Move Canhão Baixo Esquerda 																	||
; | Descrição: Vai mover o Canhão para baixo e para a Esquerda											||
; |-----------------------------------------------------------------------------------------------------||
												;														||
canhaoBaixoEsq: 	MOV 	R6, limCanhaoBaixo 	; Limite inferior para o canhão 						||
					MOV 	R7, limCanhaoEsq 	; Limite esquerdo para o canhão 						||
					CMP 	R1, R6 				; Verifica se o Canhão já está o mais abaixo possível 	||
					JZ 		canhaoBaixoEsqFim 	; Não se pode mover										||
					CMP 	R2, R7 				; Verifica se o Canhão já está o mais à direita possível||
					JZ 		canhaoBaixoEsqFim 	; Não se pode mover										||
					ADD 	R1, R9 				; Valor da linha para onde vai o canhão					||
					ADD 	R2, R10				; Valor da coluna para onde vai o canhão				||
					MOV 	[R4], R1 			; Guarda na memória as novas coordenadas do canhão		||
					ADD 	R4, 2				;														||
					MOV 	[R4], R2			;														||
												; 														||
canhaoBaixoEsqFim:	RET 						;														||
												;														||
;-------------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Move Canhão Direita		 																	||
; | Descrição: Vai mover o Canhão para a direita														||
; |-----------------------------------------------------------------------------------------------------||
												;														||
canhaoDireita: 		MOV 	R6, limCanhaoDir 	; Limite direito para o Canhão 							||
					CMP 	R2, R6 				; Verifica se o Canhão já está o mais à direita possível||
					JZ 		canhaoDireitaFim	; Não se pode mover 									||
					ADD 	R1, R9 				; Valor da linha para onde vai o canhão					||
					ADD 	R2, R10				; Valor da coluna para onde vai o canhão				||
					MOV 	[R4], R1 			; Guarda na memória as novas coordenadas do canhão		||
					ADD 	R4, 2				;														||
					MOV 	[R4], R2			;														||
												; 														||
canhaoDireitaFim:	RET 						;														||
												;														||
;-------------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Move Canhão Esquerda	 																	||
; | Descrição: Vai mover o Canhão para a esquerda														||
; |-----------------------------------------------------------------------------------------------------||
												;														||
canhaoEsquerda: 	MOV 	R6, limCanhaoEsq 	; Limite esquerdo para o Canhão							||
					CMP 	R2, R6 				; Verifica se o Canhão já está o mais à esquerda 		||
					JZ 		canhaoEsquerdaFim	; possível												||
					ADD 	R1, R9 				; Valor da linha para onde vai o canhão					||
					ADD 	R2, R10				; Valor da coluna para onde vai o canhão				||
					MOV 	[R4], R1 			; Guarda na memória as novas coordenadas do canhão 		||
					ADD 	R4, 2				;														||
					MOV 	[R4], R2			;														||
												; 														||
canhaoEsquerdaFim:	RET 						;														||
												;														||
;-------------------------------------------------------------------------------------------------------||
; |#####################################################################################################||


; |#####################################################################################################||
; |-----------------------------------------------------------------------------------------------------||
; | Função: Inicializa Aviões 																			||
; | Descrição: Vai desenhar os Aviões nas coordenadas iniciais 											||
; |-----------------------------------------------------------------------------------------------------||
												;														||
inicializaAvioes:	MOV 	R8, 0 				; 														||
					MOV 	R9, numAvioes 		; Número máximo de Aviões 								||
					MOV 	R4, coordenAviao 	; Endereço das coordenadas do Avião 					||
ciclo55:			MOV 	R1, [R4]			; Valor da linha onde se começa a desenhar o Avião 	 	||
					ADD 	R4, 2				;														||
					MOV 	R2, [R4]			; Valor da coluna onde se começa a desenhar o Avião 	||
												;														||
					CALL 	escreveAviao		; Escreve o avião										||
												;														||
					ADD 	R4, 2				; Endereço da linha do próximo avião 					||
					ADD 	R8, 1				; Próximo Avião 										||
					CMP 	R8, R9 				; Número limite de Aviões 								||
					JNZ		ciclo55				; 														||
												; 														||
					RET 						; 														||
												;														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Escreve Avião 																				||
; | Descrição: Vai desenhar o Avião nas coordenadas que se indicarem									||
; |-----------------------------------------------------------------------------------------------------||
												; 														||
escreveAviao: 		PUSH 	R0 					; 						 								||
					PUSH 	R4 					; 														||
					PUSH 	R9 					; 														||
												; 														||
					MOV 	R0, aviaoComp 		; Máscara para aplicar nas linhas do Avião  			||
					MOV 	R7, aviaoAlt 		; Altura máxima do Avião 								||
					MOV 	R9, 00H		 		; Valor do endereço de cada Linha do Avião  			||
												; 														||
cicloAviao:			MOV 	R4, drawAviao 		; Endereço do desenho do Avião 	 						||
					ADD 	R4, R9				; Endereço da Linha a desenhar 							||
					MOVB 	R5, [R4]			; Valor da Linha a desenhar 							||
					CALL 	escreveLinha		; Vai desenhar a respetiva linha 						||
												; 														||
					ADD 	R1, 1				; 														||
					ADD 	R9, 1 				; Próxima linha 										||
					CMP 	R7, R9 				; Enquanto R9 não for da altura do Avião, continua 		||
					JNZ 	cicloAviao 			; a desenhar o mesmo 									||
												;														||
					CALL 	geraAvioesAlea  	; para os aviões e para o cartucho 						||
												; 														||
					POP 	R9 					; 														||
					POP 	R4 					;														||
					POP 	R0					; 														||
					RET 						; 														||
												; 														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Apaga Avião 																				||
; | Descrição: Vai apagar o Avião nas coordenadas que se indicarem										||
; |-----------------------------------------------------------------------------------------------------||
												; 														||
apagaAviao: 		PUSH 	R0 					; 					 	 								||
					PUSH 	R1					; 														||
					PUSH 	R7 					; 										 				||
					PUSH 	R9 					;														||
												; 														||
					MOV 	R0, 00H 			; 											 			||
					MOV 	R7, aviaoAlt 		; Altura máxima do Avião 								||
					MOV 	R9, 00H		 		; Valor do endereço de cada Linha do Avião  			||
												; 														||
cicloAviao22:		CALL 	apagaLinhaA			; Vai apagar a respetiva linha 							||
												; 														||
					ADD 	R1, 1				; 														||
					ADD 	R9, 1 				; Próxima linha 										||
					CMP 	R7, R9 				; Enquanto R9 não for da altura do Avião, continua 		||
					JNZ 	cicloAviao22		; a apagar o mesmo 										||
												; 														||
					POP 	R9 					; 														||
					POP		R7 					; 														||
					POP 	R1 					;														||
					POP 	R0					; 														||
					RET 						; 														||
												; 														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Move Aviões 			 																	||
; | Descrição: Vai mover os Aviões para a esquerda de acordo com o Relógio 2 							||
; |-----------------------------------------------------------------------------------------------------||
												;														||
moveAvioes:			MOV 	R8, 0				;														||
					MOV 	R9, numAvioes 		; Número máximo de Aviões								||
					MOV 	R4, coordenAviao  	; Coordenadas do Avião  								||
					MOV 	R3, limAviaoEsq		; Limite esquerdo do avião 								||
 												;														||
ciclo66:			MOV 	R1, [R4] 			; Valor da linha onde se encontra o avião				||
					ADD 	R4, 2				;														||
					MOV 	R2, [R4]			; Valor da coluna onde se encontra o avião				||
												;														||
					CALL 	apagaAviao 			; Apaga o avião já existente 							||
												;														||
					CMP 	R2, R3				; Verifica se o avião já se encontra no limite 		 	||
					JNZ		moveAvioes11		; Continua a andar para a esquerda 						||
												; 														||
					CALL 	repoeAviao 			; 														|| 
												;														||
moveAvioes11:		SUB 	R2, 1				; Avião desloca-se um pixel para a esquerda 			||
					MOV 	[R4], R2			; Guarda o novo valor da coluna na memória				||
												;														||
					CALL 	escreveAviao		; Escreve novamente o avião nas novas coordenadas		||
												;														||
					ADD 	R8, 1				; 														||
					ADD 	R4, 2				; Coordenadas do próximo objeto							||
					CMP 	R8, R9				; Verifica se já moveu todos os aviões					||
					JNZ 	ciclo66				; Ainda não, logo vai escrever o próximo				||
												;														||
					RET 						;														||
												;														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Repõe Avião 			 																	||
; | Descrição: Vai repor o Avião no início do Pixel Screen sempre que este chegue ao final do mesmo 	||
; | 		   ou seja atingido por um missil 															||
; |-----------------------------------------------------------------------------------------------------||
												;														||
repoeAviao: 		MOV 	R2, limAviaoDir		; Já chegou ao limite, volta ao início					||
					MOV 	R5, aviaoNumAleaX	; Endereço do valor da linha aleatória dos aviões		||
					MOV 	R6, aviaoNumAlea 	; Endereço das linhas que o avião pode começar 			||
					MOV 	R5, [R5]			;														||
					ADD 	R6, R5 				;														||
					MOV 	R1, [R6]			; Valor da linha onde o avião vai ser escrito			||
					SUB 	R4, 2				;														||
					MOV 	[R4], R1 			; Guarda o novo valor da linha do avião 				||
					ADD 	R4, 2 				;														||
												;														||
					RET 						;														||
												;														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Gera Aleatório Aviões	 																	||
; | Descrição: Vai gerar um número aleatório para colocar na linha do Avião 							||
; |-----------------------------------------------------------------------------------------------------||
												;														||
geraAvioesAlea: 	MOV  	R5, aviaoNumAleaX 	; Endereço do número aleatório 							||
					MOV 	R7, aviaoLinhas 	; Número máximo de linhas que o avião pode variar		||
					MOV 	R6, [R5]			; Valor do número aleatório								||
					ADD 	R6, 2				;														||
					CMP 	R6, R7 				;														||
					JNZ 	geraAvioesAlea0 	;														||
					MOV 	R6, 0				;														||
geraAvioesAlea0:	MOV 	[R5], R6			;														||
												;														||
					RET							;														||
												;														||
; |-----------------------------------------------------------------------------------------------------||
; |#####################################################################################################||


; |#####################################################################################################||
; |-----------------------------------------------------------------------------------------------------||
; | Função: Inicializa Cartucho																			||
; | Descrição: Vai desenhar o Cartucho nas coordenadas iniciais											||
; |-----------------------------------------------------------------------------------------------------||
												;														||
inicializaCartucho:	MOV 	R1, iniciaCartuchoL	; Valor da linha onde vai ser escrito o Cartucho 		||
					MOV 	R2, iniciaCartuchoC ; Valor da coluna onde vai ser escrito o Cartucho 		||
					MOV 	R3, coordenCartucho ; Endereço das coordenadas do Cartucho 					||
					MOV 	[R3], R1 			; 														||
					ADD 	R3, 2				;														||
					MOV 	[R3], R2 			;														||
												;														||
					CALL 	escreveCartucho 	; Escreve o cartucho									||
												;														||
					RET 						; 														||
												;														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Escreve Cartucho 																			||
; | Descrição: Vai desenhar o Cartucho nas coordenadas que se indicarem									||
; |-----------------------------------------------------------------------------------------------------||
												; 														||
escreveCartucho:	PUSH 	R0 					; 						 	 							||
					PUSH 	R5					;														||
												; 														||
					MOV 	R0, cartuchoComp 	; Máscara para aplicar nas linhas do Cartucho 			||
					MOV 	R7, cartuchoAlt 	; Altura máxima do Cartucho 							||
					MOV 	R9, 00H		 		; Valor do endereço de cada Linha do Cartucho  			||
												; 														||
cicloCartucho:		MOV 	R4, drawCartucho	; Endereço do desenho do Cartucho	 					||
					ADD 	R4, R9				; Endereço da Linha a desenhar 							||
					MOVB 	R5, [R4]			; Valor da Linha a desenhar 							||
					CALL 	escreveLinha		; Vai desenhar a respetiva linha 						||
												; 														||
					ADD 	R1, 1				; 														||
					ADD 	R9, 1 				; Próxima linha 										||
					CMP 	R7, R9 				; Enquanto R9 não for da altura do Cartucho, continua 	||
					JNZ 	cicloCartucho		; a desenhar o mesmo 									||
												; 														||
					POP 	R5 					;														||
					POP 	R0					; 														||
					RET 						; 														||
												; 														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Apaga Cartucho 																				||
; | Descrição: Vai apagar o Cartucho nas coordenadas que se indicarem									||
; |-----------------------------------------------------------------------------------------------------||
												; 														||
apagaCartucho: 		PUSH 	R0 					; 					 	 								||
					PUSH 	R1					; 														||
					PUSH 	R9 					;														||
												; 														||
					MOV 	R0, 00H 			; 											 			||
					MOV 	R7, cartuchoAlt 	; Altura máxima do Avião 								||
					MOV 	R9, 00H		 		; Valor do endereço de cada Linha do Avião  			||
												; 														||
cicloCartucho22:	CALL 	apagaLinha			; Vai apagar a respetiva linha 							||
												; 														||
					ADD 	R1, 1				; 														||
					ADD 	R9, 1 				; Próxima linha 										||
					CMP 	R7, R9 				; Enquanto R9 não for da altura do Avião, continua 		||
					JNZ 	cicloCartucho22		; a apagar o mesmo 										||
												; 														||
					POP 	R9 					;														||
					POP 	R1 					;														||
					POP 	R0					; 														||
					RET 						; 														||
												; 														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Move Cartucho 			 																	||
; | Descrição: Vai mover o Cartucho para a esquerda de acordo com o Relógio 2 							||
; |-----------------------------------------------------------------------------------------------------||
												;														||
moveCartucho:		CALL 	geraCartuchoAlea 	; Rotinas que vão tratar de gerar um número aleatório 	||
													;													||
					MOV 	R4, coordenCartucho		; Coordenadas do Cartucho  							||
					MOV 	R5, cartuchoConta 		; Endereço do contador do cartucho 					||
					MOV 	R7, cartuchoTime 		; Limite que o cartucho tem para se mover novamente	||
					MOV 	R8, cartuchoNumAleaX 	; Endereço do valor da coluna aleatória do cartucho ||
					MOV 	R9, cartuchoNumAlea 	; Endereço das colunas onde o cartucho pode começar ||
													;													||
					MOV 	R6, [R5]			; Valor do contador do cartucho 						||
					CMP 	R6, R7 				; Verifica se já chegou o momento de mover o cartucho 	||
					JNZ		moveCartucho11 		; Ainda não chegou por isso mantém o cartucho 			||
 												;														||
 					MOV 	R1, [R4] 			; Valor da linha onde se encontra o cartucho			||
					ADD 	R4, 2				;														||
					MOV 	R2, [R4]			; Valor da coluna onde se encontra o cartucho 			||
												;														||
					CALL 	apagaCartucho 		; Apaga o cartucho já existente							||
												;														||
					MOV 	R8, [R8]			; 														||
					ADD 	R9, R8				; 														||
					MOV 	R2, [R9] 			; Valor da coluna onde vai ser escrito o cartucho		||
					MOV 	[R4], R2			; Guarda o valor das novas coordenadas do cartucho 		||
												;														||
					CALL 	escreveCartucho		; Escreve o cartucho nas novas coordenadas				||
					MOV 	R6, 0				;														||
												;														||
moveCartucho11:		ADD 	R6, 1 				;														||
					MOV 	[R5], R6 			;														||
					RET 						;														||
												;														||
;-------------------------------------------------------------------------------------------------------||
;																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Gera Aleatório Cartucho	 																	||
; | Descrição: Vai gerar um número aleatório para colocar na coluna do Cartucho							||
; |-----------------------------------------------------------------------------------------------------||
													;													||
geraCartuchoAlea: 	MOV  	R5, cartuchoNumAleaX 	; Endereço do número aleatório 						||
					MOV 	R7, cartuchoColunas		; Número máximo de colunas que o cartucho varia		||
					MOV 	R6, [R5]				; Valor do número aleatório							||
					ADD 	R6, 2				;														||
					CMP 	R6, R7 				;														||
					JNZ 	geraCartuchoAlea0 	;														||
					MOV 	R6, 0				;														||
geraCartuchoAlea0:	MOV 	[R5], R6			;														||
												;														||
					RET							;														||
												;														||
; |-----------------------------------------------------------------------------------------------------||
; |#####################################################################################################||


; |#####################################################################################################||
; |-----------------------------------------------------------------------------------------------------||
; | Função: Inicializa Mísseis 	 																		||
; | Descrição: Vai colocar todos os mísseis disponíveis para serem lançados								||
; |-----------------------------------------------------------------------------------------------------||
												;														||
inicializaMisseis: 	MOV 	R5, coordenMissil 	; Endereço onde se encontram as coordenadas dos misseis ||
					MOV 	R6, 0				;														||
					MOV 	R7, numeroMisseis 	; Número máximo de misseis 								||
					MOV 	R1, 0 				;														||
ciclo99:			MOV 	[R5], R1			;														||
					ADD 	R5, 2				;														||
					MOV 	[R5], R1			;														||
					ADD 	R6, 1 				;														||
					CMP 	R7, R6 				; Verifica se já inicializou todas as balas				||
					JNZ 	ciclo99 			; Vai inicializar a próxima bala 						||
												;														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Lança Mísseis 	 																			||
; | Descrição: Vai lançar um Míssel do Canhão 															||
; |-----------------------------------------------------------------------------------------------------||
												; 														||
lancaMissil:		PUSH 	R6					;														||
					PUSH 	R7					;														||
												;														||
					MOV 	R0, valorInterrup1 	; Local na memória referente à Interrupção 1			||
					MOV 	R10, [R0] 			; 														||
					CMP 	R10, 1				; Verifica se a interrupção 1 ocorreu					||
					JNZ 	lancaMissilFim 		; Não ocorreu logo os mísseis não vão ser escritos		||
												;														||
					MOV 	R6, 0				;														||
					MOV 	R7, numeroMisseis	; Número máximo de mísseis 								||
					MOV 	R5, coordenMissil	; Endereço das coordenadas do Missil					||
					ADD 	R5, 2 				; 							 							||
proxMissil:			MOV 	R2, [R5] 			; Coordenada coluna do Míssil							||
					CMP 	R2, 0				; Ver se existe algum míssil pronto a lançar			||
					JZ 		lancaMissil22 		; 														||
					ADD 	R5, 4 				; Coordenadas do próximo míssil							||
					ADD 	R6, 1				; 														||
					CMP 	R6, R7				; Verifica se já lançou todos os mísseis disponíveis 	||
					JNZ  	proxMissil			; Lançar próximo míssil 								||
					JMP 	lancaMissilFim		; Já lançou todos os mísseis disponíveis				||
												;														||
lancaMissil22:		SUB 	R5, 2 				; 														||
					MOV 	R3, coordenCanhao 	; Endereço das coordenadas do Canhão 					||
					MOV 	R1, [R3]			; Valor da linha onde começa o Canhão 					||
					ADD 	R3, 2				;														||
					MOV 	R2, [R3]			; Valor da coluna onde começa o Canhão 					||
												;														||
					SUB 	R1, linhaPixel		; Coordenadas onde o pixel vai ser escrito 				||
					ADD 	R2, colunaPixel		;														||
					MOV 	[R5], R1			; Valor da linha onde se vais escrever o missil	a sair 	||
					ADD 	R5, 2				; do canhao												||
					MOV 	[R5], R2			; Valor da coluna onde se encontra o missil inicial		||
					CALL 	escreveMissil 		; Escreve o missil a sair do canhão 					||
												;														||
lancaMissilFim:		POP 	R7 					;														||
					POP 	R6					;														||
					RET 						;														||
												;														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Escreve Míssil	 																			||
; | Descrição: Vai escrever um Míssel do Canhão 														||
; |-----------------------------------------------------------------------------------------------------||
												;														||
escreveMissil: 		PUSH 	R0 					;														||
												; 														||
					MOV 	R0, 1				; 														||
					CALL 	escrevePixel 		; Escreve o Pixel nas coordenadas pretendidas			||
												;														||
					POP 	R0 					;														||
					RET 						;														||
												;														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Apaga Míssil	 																			||
; | Descrição: Vai apagar um Míssel do Canhão 															||
; |-----------------------------------------------------------------------------------------------------||
												;														||
apagaMissil: 		PUSH 	R0 					; 														||
												; 														||
					MOV 	R0, 0				; 														||
					CALL 	escrevePixel 		; Apaga o Pixel nas coordenadas pretendidas				||
												;														||
					POP 	R0 					;														||
					RET 						;														||
												;														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Move Míssil	 																				||
; | Descrição: Vai mover os Mísseis do Canhão 															||
; |-----------------------------------------------------------------------------------------------------||
												;														||
moveMissil: 		PUSH 	R6					;														||
					PUSH 	R7					;														||
												;														||
					MOV 	R0, valorInterrup1 	; Local na memória referente à Interrupção 1			||
					MOV 	R10, [R0] 			;														||
					CMP 	R10, 1				; Verifica se a interrupção 1 ocorreu					||
					JNZ 	moveMissilFim 		; Não ocorreu logo não move os mísseis					||
												;														||
					MOV 	R6, 0				;														||
					MOV 	R7, numeroMisseis	; Número máximo de mísseis 								||
												;														||
					MOV 	R5, coordenMissil 	; Endereço da memória onde as coordenadas se encontram	||
moveMissilSeguinte:	MOV 	R1, [R5]			; Valor da linha do missil								||
					ADD 	R5, 2				;														||
					MOV 	R2, [R5]			; Valor da coluna do missil								||
												;														||
					CMP 	R2, 0				; Verifica se o míssil em questão está à espera de ser	||
					JNZ		ciclo87				; lançado ou não. Se tiver nas suas coordenadas 		||
					CMP 	R1, 0				; iniciais, não será verficada possíveis colisões nem	||
					JZ 		repoeMissil0		; será movido											||
												;														||
ciclo87:			CALL 	colisoes 			; 														||
					CMP 	R8, 1				; Verifica se o míssil colide com algum objecto. Se sim	||
					JZ 		repoeMissil0        ; fica pronto para ser disparado novamente 				||
												;														||
					CMP 	R1, 0				; Verifica se já chegou ao final do Pixel Screen. 		||
					JZ 		repoeMissil0 		; 														||
												;														||
					CALL 	apagaMissil 		; Apaga o missil inicial								||
					SUB 	R1, 1				; Move a linha um valor para cima						||
					SUB 	R5, 2 				;														||
					MOV 	[R5], R1 			; Guarda na memória o valor dessa linha					||
					CALL 	escreveMissil 		; Escreve o missil com as novas coordenadas				||
					ADD 	R5, 2				; Endereço do próximo míssil							||
					JMP 	ciclo88				; 														||
												;														||
repoeMissil0: 		CALL 	repoeMissil			; Coloca o míssil diponivel para ser movido				||
ciclo88:			ADD 	R5, 2				;														||
					ADD 	R6, 1				; 														||
					CMP 	R6, R7				; Verifica se já foram movidos todos os mísseis 		||
					JNZ		moveMissilSeguinte 	; Move o próximo míssil 								||
												;														||
moveMissilFim:		MOV 	R10, 0 				; Volta a colocar a 0 o valor da interrupção			||
					MOV 	[R0], R10 			; Guarda esse valor na memória							||
												;														||
					POP 	R7					;														||
					POP 	R6					;														||
					RET 						;														||
												;														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Repõe Míssil	 																			||
; | Descrição: Vai repor as coordenadas do Míssil do Canhão 											||
; |-----------------------------------------------------------------------------------------------------||
												;														||
repoeMissil: 		CALL 	apagaMissil			;														||
												;														||
ciclo0123:			MOV 	R1, 0				; Coloca as coordenadas do Míssil a 0					||
					MOV 	R2, 0 				;														||
					SUB 	R5, 2				;														||
					MOV 	[R5], R1 			; Valor da linha do míssil								||
					ADD 	R5, 2				; 														||
					MOV 	[R5], R2 			; Valor da coluna do míssil 							||
												;														||
					RET 						;														||
												;														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Adiciona Míssil	 																			||
; | Descrição: Vai adicionar três balas sempre que se acerta no cartucho								||
; |-----------------------------------------------------------------------------------------------------||
;												;														||
;adicionaMissil:		PUSH 	R3
;					PUSH 	R4
;					PUSH 	R5
;
;					MOV 	R5, numeroMisseis 	; Endereço que contém o número de misseis disponiveis	||
;					MOV 	R4, [R5]			; Valor do número de míssies							||
;					MOV 	R3, numMaxMisseis	;														||
;					ADD 	R4, 3				;														||
;					CMP 	R3, R4				; Verifica se adicionou mais do que o limite 			||
;					JNN 	adicionaMissilFim	;														||
;					MOV 	R4, 09H 			; Coloca o número máximo de misseis prontos a sere 		||
;												; disparados											||
;adicionaMissilFim: 	MOV 	[R5], R4 			; 														||
;												;														||
;					POP 	R5
;					POP 	R4
;					POP 	R3
;					RET
; |-----------------------------------------------------------------------------------------------------||
; |#####################################################################################################||

; |#####################################################################################################||
; |-----------------------------------------------------------------------------------------------------||
; | Função: Escreve Explosão 																			||
; | Descrição: Vai desenhar o Explosão nas coordenadas que se indicarem									||
; |-----------------------------------------------------------------------------------------------------||
												; 														||
escreveExplosao:	PUSH 	R0 					; Máscara para o Explosão 	 							||
					PUSH 	R1 					;														||
					PUSH 	R4 					; Endereço do Explosão 									||
					PUSH 	R5					; Valor da Linha que se quer desenhar 		 			||
					PUSH 	R7 					; Comprimento da Coluna do Explosão 		 			||
					PUSH 	R9 					; Valor para retirar a Linha desejada 					||
												; 														||
					MOV 	R0, explosaoComp 	; Máscara para aplicar nas linhas da Explosão  			||
					MOV 	R7, explosaoAlt 	; Altura máxima do Explosão 							||
					MOV 	R9, 00H 	 		; Valor do endereço de cada Linha da Explosão  			||
												; 														||
cicloExplosao:		MOV 	R4, drawExplosao	; Endereço do desenho do Explosão 	 					||
					ADD 	R4, R9				; Endereço da Linha a desenhar 							||
					MOVB 	R5, [R4]			; Valor da Linha a desenhar 							||
					CALL 	escreveLinha		; Vai desenhar a respetiva linha 						||
												; 														||
					ADD 	R1, 1				; 														||
					ADD 	R9, 1 				; Próxima linha 										||
					CMP 	R7, R9 				; Enquanto R9 não for da altura do Explosão, continua 	||
					JNZ 	cicloExplosao		; a desenhar o mesmo 									||
												; 														||
					POP 	R9 					; 														||
					POP		R7 					; 														||
					POP 	R5 					; 														||
					POP 	R4					; 														||
					POP 	R1					;														||
					POP 	R0					; 														||
					RET 						; 														||
												; 														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Apaga Explosão 																				||
; | Descrição: Vai apagar a Explosão nas coordenadas que se indicarem									||
; |-----------------------------------------------------------------------------------------------------||
												; 														||
apagaExplosao: 		PUSH 	R0 					;														||
					PUSH 	R1					; 														||
					PUSH 	R7					;														||
					PUSH 	R9 					;														||
												; 														||
					MOV 	R0, 00H 	 		; Máscara para apagar os pixeis				 			||
					MOV 	R7, explosaoAlt		; Altura máxima da Explosão								||
					MOV 	R9, 00H 	 		; Valor do endereço de cada Linha da Explosão  			||
												;														||
cicloExplosao22:	CALL 	apagaLinha			; Vai apagar a respetiva linha 							||
												; 														||
					ADD 	R1, 1				; 														||
					ADD 	R9, 1 				; Próxima linha 										||
					CMP 	R7, R9 				; Enquanto R9 não for da altura da Explosão, continua 	||
					JNZ 	cicloExplosao22		; a apagar o mesmo 										||
												; 														||
					POP 	R9 					; 														||
					POP 	R7 					;														||
					POP 	R1					;														||
					POP 	R0					;														||
					RET 						; 														||
												; 														||
; |-----------------------------------------------------------------------------------------------------||
; |#####################################################################################################||

; |#####################################################################################################||
; |-----------------------------------------------------------------------------------------------------||
; | Função: Move Objetos 																				||
; | Descrição: Vai mover os Objetos todos 																||
; |-----------------------------------------------------------------------------------------------------||
												;														||
moveObjetos:		MOV 	R0, valorInterrup2 	; Local da memória referente à Interrupção 1 			||
					MOV 	R10, [R0] 			; 														||
					CMP 	R10, 1 				; Verifica se a interrupção 1 foi corrida 				||
					JNZ 	moveObjectosFim 	; Não foi corrida logo não faz nada						||
												;														||
					CALL 	moveAvioes			; Vai mover os aviões									||
					CALL 	moveCartucho 		; Vai mover o cartuchos 					 			||
 												;														||
moveObjectosFim:	MOV 	R10, 0 				; Coloca o valor da interrupção a 0						||
					MOV 	[R0], R10			;														||
 												; 														||
 					CALL 	moveMissil 			; Vai mover os mísseis que já se encontram no ecrã		||
 												;														||
 					RET 						;														||
												;														||
;-------------------------------------------------------------------------------------------------------||
; |#####################################################################################################||


; |#####################################################################################################||
; |-----------------------------------------------------------------------------------------------------||
; | Função: Colisões 	 			 																	||
; | Descrição: Vai verificar se existe colisões das balas com os objectos 					 			||
; |-----------------------------------------------------------------------------------------------------||
												;												 		||
colisoes: 			PUSH 	R0					;														||
					PUSH 	R5					;														||
					PUSH 	R6					;														||
					PUSH 	R7					;														||
					PUSH 	R9					;														||
					PUSH 	R10					;														||
												;														||
					MOV 	R3, R1				; Registos com as coordenadas do míssil 				||
					MOV 	R4, R2				;														||
												;														||
					CALL 	aviaoColisao 		; 														||
					CMP 	R8, 1				; 														||
					JNZ 	ciclo100 	 		; Não houve colisão, logo verifica para o cartucho		||
					CALL 	apagaAviao 			; Vai apagar o avião que colidiu 						||
												;														||	
					PUSH 	R1					;														||
					PUSH 	R2					;														||
					PUSH 	R4					;														||
					PUSH 	R5					;														||
					PUSH 	R6					;														||
												;														||
					MOV 	R4, R9 				; Endereço das coordenadas do avião abatido				||
					CALL 	repoeAviao			; Repõe o avião no limite direito do Pixel Screen		||
					MOV 	[R4], R2			; Guarda o valor da coluna nas coordenadas				||
												;														||
					POP 	R6					;														||
					POP 	R5					;														||
					POP 	R4					;														||
					POP 	R2					;														||
					POP 	R1					;														||
												;														||
					CALL 	escreveExplosao		; Escreve a explosão nas coordenadas do avião abatido 	||
					CALL 	pontuacao 			; Incrementa um valor à pontuação 						||
					CALL 	apagaExplosao 		; Apaga a Explosão do Avião								||
					JMP 	colisoesFim			; 														||
												; 														||
ciclo100:			CALL  	cartuchoColisao 	;														||
					CMP 	R8, 1 				; 														||
					JNZ 	colisoesFim    		; Volta para a função anterior e retira o míssil do 	||
												;														||
colisoesFim:		MOV 	R1, R3				;														||
					MOV 	R2, R4				;												 		||
												;														||
					POP 	R10					;														||
					POP 	R9					;														||
					POP 	R7					;														||
					POP 	R6					;														||
					POP 	R5					;														||
					POP 	R0					;														||
					RET 						;														||
												;														||
; |-----------------------------------------------------------------------------------------------------||
;																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Colisão Avião 			 																	||
; | Descrição: Vai verificar se existe colisão de cada avião com uma determinada bala 		 			||
; |-----------------------------------------------------------------------------------------------------||
												;														||
aviaoColisao:		MOV 	R0, numAvioes		;														||
					MOV 	R7, numPixeisAviao	;														||
					MOV 	R9, coordenAviao	;														||
					MOV 	R10, colisaoAviao	;														||
					 							;														||
aviaoColisao00:		MOV 	R1, [R9] 			; Coordenadas de referência do avião					||
					ADD 	R9, 2 				;														||
					MOV 	R2, [R9] 			;														||
												;														||
					CALL	colisaoPix			; Verifica se hovue colisão da bala com o avião			||
												;														||
					CMP 	R8, 1				; Verifica se houve colisão entre a bala e o avião 		||
					JZ 		aviaoColisaoFim 	;														||
					ADD 	R9, 2				;														||
					SUB 	R0, 1				; Próximo avião 										||
					JNZ 	aviaoColisao00		;														||
												;														||
aviaoColisaoFim: 	RET 						;														||
												;														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Colisão Cartucho		 																	||
; | Descrição: Vai verificar se existe colisão do cartucho com uma determinada bala 		 			||
; |-----------------------------------------------------------------------------------------------------||
												;														||
cartuchoColisao:	MOV 	R0, numCartuchos 	;														||
					MOV 	R7, numPixeisCartu	;														||
					MOV 	R9, coordenCartucho	;														||
					MOV 	R10, colisaoCartu	;														||
					 							;														||
cartuchoColisao00:	MOV 	R1, [R9] 			; Coordenadas de referência do avião					||
					ADD 	R9, 2 				;														||
					MOV 	R2, [R9] 			;														||
												;														||
					CALL	colisaoPix			; Verifica se hovue colisão da bala com o avião			||
												;														||
					CMP 	R8, 1				; Verifica se houve colisão entre a bala e o avião 		||
					JZ 		cartuchoColisaoFim 	;														||
					ADD 	R9, 2				;														||
					SUB 	R0, 1				; Próximo avião 										||
					JNZ 	cartuchoColisao00	;														||
												;														||
cartuchoColisaoFim: RET 						;														||
												;														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Colisão Pixel			 																	||
; | Descrição: Vai verificar se as coordenadas de cada pixel do avião e do cartucho são coincidentes 	||
; | 		   com as coordenadas de cada missil 														||
; |-----------------------------------------------------------------------------------------------------||
												;														||
colisaoPix:			PUSH 	R5 					;														||
					PUSH 	R7					;														||
					PUSH 	R10					;														||
												; de referência do avião								||
colisaoPix0:		MOV 	R5, [R10]			; Valor a somar à linha do avião 						||
					ADD 	R10, 2				;														||
					MOV 	R6, [R10]			; Valor a somar à coluna do avião 						||
												;														||
					ADD 	R5, R1				; Coordenada linha de um pixel do avião					||
					CMP 	R5, R3				; Compara se é coincidente com a coordenada do missil	||
					JNZ    	colisaoPix1			; Não é coincidente, verifica outro pixel 				||
					ADD 	R6, R2				; Coordenada coluna de um pixel do avião 				||
					CMP 	R6, R4				; Compara se é coincidente com a coordenada do missil 	||
					JZ 		colisaoPixSim		; É coincidente, logo houve colisão 					||
colisaoPix1:		SUB 	R7, 1				;														||
					JZ 		colisaoPixNao		; 														||
					ADD 	R10, 2				; 														||
					JMP 	colisaoPix0 		;														||
												;														||
colisaoPixSim:		MOV 	R8, 1				; Houve colisão											||
					JMP 	colisaoPixFim		;														||
colisaoPixNao:		MOV 	R8, 0				; Não houve colisão 									||
												;														||
colisaoPixFim: 		POP 	R10					;														||
					POP 	R7 					;														||
					POP 	R5					;														||
					RET							;														||
												;														||
; |-----------------------------------------------------------------------------------------------------||
; |#####################################################################################################||


; |#####################################################################################################||
; |-----------------------------------------------------------------------------------------------------||
; | Função: Inicializa Pontuação	 																	||
; | Descrição: Rotina que inicializa a pontuação do jogo a 0											||
; |-----------------------------------------------------------------------------------------------------||
												;														||
inicializaPontos: 	PUSH 	R1 					;														||
					PUSH 	R5					;														||			
												;														||
					MOV 	R5, perifSaida_1 	; Periférico dos Displays								||
					MOV 	R1, 0 	 			; Valor inicial da pontuação do jogo					||
					MOVB 	[R5], R1 			; Guarda dentro do Periférico de Saída					||
					MOV 	R5, valorpontuacao 	; 														||
					MOVB 	[R5], R1			; Guarda na memória										||
												;														||
					POP 	R5					;														||
					POP 	R1					;														||
					RET 						;														||
												;														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Pontuação 				 																	||
; | Descrição: Sempre que haja uma colisão de uma bala com um avião, é incrementado 1 ao valor da 		||
; | 		   pontuação, escrevendo para o Display a mesma 											||
; |-----------------------------------------------------------------------------------------------------||
												;														||
pontuacao: 			PUSH 	R1					;														||
					PUSH 	R2					;														||
					PUSH 	R3					;														||
					PUSH 	R5					;														||
												;														||
					MOV 	R5, valorpontuacao	; Endereço que contém o valor da pontuação 				||
					MOV 	R2, [R5] 			; Valor actual da pontuação 							||
					MOV 	R3, 099H 			; Verifica se já chegou à pontuação máximo				||
					CMP 	R2, R3				; 														||
					JZ 		letGameEnd1			; Já chegou à pontuação máximo logo acaba o jogo 		||
					MOV 	R1, R2 				; 														||
					MOV 	R3, 0FH 			; 														||
					AND 	R1, R3 				; Bits 0-3 do Display 						 			||
					MOV 	R3, 09H 			; 														||
					CMP 	R1, R3				; Verifica se já chegaram a 9							||
					JZ 		pontuacao09			; 														||
					ADD 	R2, 1				; Não chegaram logo continua a somar 1					||
					JMP 	pontuacaoFim		;														||
												;														||
pontuacao09: 		ADD 	R2, 7				; Já chegaram logo soma 7 								||
pontuacaoFim:		MOV 	[R5], R2 			; Guarda dentro da memória								||
					MOV 	R5, perifSaida_1 	;														||
					MOVB 	[R5], R2 			; Coloca no periférico									||
					JMP 	ciclo1111			;														||
												;														||
letGameEnd1: 		CALL 	letGameEnd 			;														||
												;														||
ciclo1111:			POP 	R5					;														||
					POP 	R3					;														||
					POP 	R2					;														||
					POP 	R1					;														||
					RET 						;														||
												;														||
; |-----------------------------------------------------------------------------------------------------||
; |#####################################################################################################||


; |#####################################################################################################||
; |-----------------------------------------------------------------------------------------------------||
; | Função: Interrupção 1			 																	||
; | Descrição: Vai mover os mísseis para cima de acordo com o Relógio 1									||
; |-----------------------------------------------------------------------------------------------------||
												;														||
interrupcao1: 		PUSH 	R0 					;														||
					PUSH 	R1					; 														||
												;														||
					MOV 	R0, valorInterrup1 	; Local da memória referente à Interrupção 1 			||
					MOV 	R1, 1 				; Permite que os misseis se possam mover				||
					MOV 	[R0], R1			;														||
												;														||
					POP 	R1					;														||
					POP 	R0					;														||
					RFE 						;														||
												;														||
; |-----------------------------------------------------------------------------------------------------||
; 																										 |
; |-----------------------------------------------------------------------------------------------------||
; | Função: Interrupção 2			 																	||
; | Descrição: Vai mover o Avião e o Cartucho para a esquerda de acordo com o Relógio 2					||
; |-----------------------------------------------------------------------------------------------------||
												;														||
interrupcao2:		PUSH 	R0 					;														||
					PUSH 	R1					; 														||
												;														||
					MOV 	R0, valorInterrup2 	; Local da memória referente à Interrupção 2 			||
					MOV 	R1, 1 				; Permite que os objectos se possam mover 				||
					MOV 	[R0], R1			;														||
												;														||
					POP 	R1					;														||
					POP 	R0					;														||
					RFE 						;														||
												;														||
; |-----------------------------------------------------------------------------------------------------||
; |#####################################################################################################||


; ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
																									   ;||
; Alterar esta parte, abstração de dados 															   ;||
																									   ;||
apagaLinhaA: 		PUSH 	R2					; 													   ;||
												; 													   ;||
					MOV 	R6, aviaoComp 		; Comprimento máximo do Canhão 						   ;||
												; 													   ;||
cicloA300:			CALL 	escrevePixel 		; Vai apagar o pixel 								   ;||
					ADD 	R2, 1				; Próxima coluna									   ;||
					SHR 	R6, 1				; Quer apagar o próximo bit 						   ;||
					JNZ 	cicloA300			; Volta a executar enquanto não apagar o último bit    ;||
												; 													   ;||
					POP 	R2					; 													   ;||
					RET 						;													   ;||
												; 													   ;||
; ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||




