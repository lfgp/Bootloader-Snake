;Inicialização do kernel 
org 0x7e00       ;localização do programa na BIOS
jmp 0x0000:start;jumper não compara nada só chama 

;olhar a linha 1012, pois tem erro

data:

;palavra reservada para a cobra com um total de 200 words (16bits)
snake: resw 200

;palavras reservadas para as strings e não é reserva de memória
score: db 'SCORE' ,0 
tempo: db 'TEMPO' ,0
press: db 'PRESS' ,0
entre: db 'ENTER' ,0
vazia: db '     ' ,0
menu: db 'SNAKE X86',0
limpa: db 'SNAKE X86',0
Lp: db 'PRESS' ,0
Le: db 'ENTER' ,0

;reservando bytes para variáveis, iniciando as variaveis zeradas (com excerção dos pontos que não mostra o valor zero)
pontos:     resb 0x01
timerzinho: resb 0x01
tempinho:   resb 0x01

	
;Dados do projeto...

;Início das Strings
printaChar:
  mov ah, 0xe ;instruções de vídeo para printar caracter quando estiver em AL
  int 10h     ;Chama a interrupção de Vídeo
  ret

printMenu:  
  mov ah, 2  ;set o posicionamento do cursor
  mov bh, 0  ;página inicial
  mov dh, 3  ;linha 
  mov dl, 13 ;coluna  
  int 10h    ;Chama a interrupção de Vídeo

  mov si, menu ;copia o valor do tempo no ponteiro SI

printM:
  lodsb       ;carrega o conteudo de SI para AL
  cmp al, 0   ;verifica se al eh igual a 0
  je fimMenu ;se for igual chama a subrotina

  mov bx, 0x0004    ;definição da cor (vermelho)
  call printaChar   ;chama a subrotina
  jmp printM       ;loop

fimMenu:
  ret

limpaMenu:  
  mov ah, 2  ;set o posicionamento do cursor
  mov bh, 0  ;página inicial
  mov dh, 3  ;linha 
  mov dl, 13 ;coluna  
  int 10h    ;Chama a interrupção de Vídeo

  mov si, limpa ;copia o valor do tempo no ponteiro SI


printLimpa:
  lodsb       ;carrega o conteudo de SI de press para AL
  cmp al, 0   ;verifica se al eh igual a 0
  je fimLimpa ;se for igual chama a subrotina

  mov bx, 0x0000    ;definição da cor (preto)
  call printaChar   ;chama a subrotina
  jmp printLimpa        ;loop

fimLimpa:
    ret 

printScore:  
  mov ah, 2  ;set o posicionamento do cursor
  mov bh, 0  ;página inicial
  mov dh, 3  ;linha 
  mov dl, 33 ;coluna  
  int 10h    ;Chama a interrupção de Vídeo

  mov si, score ;copia o valor do tempo no ponteiro SI

printS:
  lodsb       ;carrega o conteudo de SI de press para AL
  cmp al, 0   ;verifica se al eh igual a 0
  je fimScore ;se for igual chama a subrotina

  mov bx, 0x0002    ;definição da cor (verde)
  call printaChar   ;chama a subrotina
  jmp printS        ;loop

fimScore:
  ret


printTempo:  
  mov ah, 2     ;set o posicionamento do cursor
  mov bh, 0     ;página inicial ("estado inicial")
  mov dh, 10    ;linha 
  mov dl, 33    ;coluna
  int 10h       ;Chama a interrupção de Vídeo
  mov si, tempo ;copia o valor do tempo no ponteiro SI

printT:
  lodsb         ;carrega o conteudo de SI de press para AL
  cmp al, 0     ;compara com o inicio da string
  je fimTempo   ;se for igual chama a subrotina

  mov bx, 0x0009   ;definição da cor (azul claro)
  call printaChar  ;chama a subrotina
  jmp printT       ;só para loop

fimTempo:
  ret


printPressioneVermelho:  
  mov ah, 2  ;set o posicionamento do cursor
  mov bh, 0  ;página inicial ("estado inicial")
  mov dh, 20 ;linha
  mov dl, 33 ;coluna
  int 10h    ;Chama a interrupção de Vídeo

  mov si, press ;para carregar

printPressVm:
  lodsb         ;carrega o conteudo de SI de press para AL
  cmp al, 0     ;verifica se chegou no fim da pilha
  je fimPressVm ;se for igual chama a subrotina 

  mov bx, 0x000c     ;definição da cor (vermelho claro)
  call printaChar    ;chama a subrotina
  jmp printPressVm   ;loop

fimPressVm:
  ret


printPressioneVerde:  
  mov ah, 2      ;set o posicionamento do cursor
  mov bh, 0      ;página inicial ("estado inicial")
  mov dh, 20     ;linha
  mov dl, 33     ;coluna
  int 10h        ;Chama a interrupção de Vídeo

  mov si, press  ;para carregar 

printPressVd:
  lodsb          ;carrega o conteudo de SI de press para AL
  cmp al, 0      ;verifica se chegou no fim da pilha
  je fimPressVd  ;se for igual chama a subrotina

  mov bx, 0x000a    ;definição da cor (verde claro)
  call printaChar   ;chama a subrotina
  jmp printPressVd  ;loop

fimPressVd:
  ret


printEnterVermelho:  
  mov ah, 2  ;set o posicionamento do cursor
  mov bh, 0  ;página inicial ("estado inicial")
  mov dh, 22 ;linha
  mov dl, 33 ;coluna
  int 10h    ;interrupção de vídeo

  mov si, entre

printEnterVm:
  lodsb          ;carrega o conteudo de SI de press para AL
  cmp al, 0      ;verifica se chegou no fim da pilha
  je fimEnterVm  ;se for igual chama a subrotina

  mov bx, 0x000c   ;definição da cor (vermelho claro)
  call printaChar  ;chama a subrotina
  jmp printEnterVm ;loop

fimEnterVm:
  ret


printEnterVerde:  
  mov ah, 2  ;set o posicionamento do cursor
  mov bh, 0  ;página inicial ("estado inicial")
  mov dh, 22 ;linha 
  mov dl, 33 ;coluna
  int 10h    ;interrupção de vídeo

  mov si, entre

printEnterVd:
  lodsb           ;carrega o conteudo de SI de press para AL
  cmp al, 0       ;verifica se chegou no fim da pilha
  je fimEnterVd   ;loop

  mov bx, 0x000a     ;definição da cor (verde claro)
  call printaChar    ;chama a subrotina
  jmp printEnterVd   ;loop

fimEnterVd:
  ret

printPressioneRed:  
  mov ah, 2  ;set o posicionamento do cursor
  mov bh, 0  ;página inicial ("estado inicial")
  mov dh, 10 ;linha
  mov dl, 15 ;coluna
  int 10h    ;Chama a interrupção de Vídeo

  mov si, press ;para carregar

printPressRd:
  lodsb         ;carrega o conteudo de SI de press para AL
  cmp al, 0     ;verifica se chegou no fim da pilha
  je fimPressRd ;se for igual chama a subrotina 

  mov bx, 0x000c     ;definição da cor (vermelho claro)
  call printaChar    ;chama a subrotina
  jmp printPressRd   ;loop

fimPressRd:
  ret


printPressioneGreen:  
  mov ah, 2      ;set o posicionamento do cursor
  mov bh, 0      ;página inicial ("estado inicial")
  mov dh, 10     ;linha
  mov dl, 15     ;coluna
  int 10h        ;Chama a interrupção de Vídeo

  mov si, press  ;para carregar 

printPressGr:
  lodsb          ;carrega o conteudo de SI de press para AL
  cmp al, 0      ;verifica se chegou no fim da pilha
  je fimPressGr  ;se for igual chama a subrotina

  mov bx, 0x000a    ;definição da cor (verde claro)
  call printaChar   ;chama a subrotina
  jmp printPressGr  ;loop

fimPressGr:
  ret


printEnterRed:  
  mov ah, 2  ;set o posicionamento do cursor
  mov bh, 0  ;página inicial ("estado inicial")
  mov dh, 12 ;linha
  mov dl, 15 ;coluna
  int 10h    ;interrupção de vídeo

  mov si, entre

printEnterRd:
  lodsb          ;carrega o conteudo de SI de press para AL
  cmp al, 0      ;verifica se chegou no fim da pilha
  je fimEnterRd  ;se for igual chama a subrotina

  mov bx, 0x000c   ;definição da cor (vermelho claro)
  call printaChar  ;chama a subrotina
  jmp printEnterRd ;loop

fimEnterRd:
  ret


printEnterGreen:  
  mov ah, 2  ;set o posicionamento do cursor
  mov bh, 0  ;página inicial ("estado inicial")
  mov dh, 12 ;linha 
  mov dl, 15 ;coluna
  int 10h    ;interrupção de vídeo

  mov si, entre

printEnterGr:
  lodsb           ;carrega o conteudo de SI de press para AL
  cmp al, 0       ;verifica se chegou no fim da pilha
  je fimEnterGr   ;loop

  mov bx, 0x000a     ;definição da cor (verde claro)
  call printaChar    ;chama a subrotina
  jmp printEnterGr   ;loop

fimEnterGr:
  ret

;limpa

;;limpa
limpaPrintPressioneRed:  
  mov ah, 2  ;set o posicionamento do cursor
  mov bh, 0  ;página inicial ("estado inicial")
  mov dh, 10 ;linha
  mov dl, 15 ;coluna
  int 10h    ;Chama a interrupção de Vídeo

  mov si, Lp ;para carregar

limpaPrintPressRd:
  lodsb         ;carrega o conteudo de SI de press para AL
  cmp al, 0     ;verifica se chegou no fim da pilha
  je fimLimpaPressRd ;se for igual chama a subrotina 

  mov bx, 0     ;definição da cor (preto)
  call printaChar    ;chama a subrotina
  jmp limpaPrintPressRd   ;loop

fimLimpaPressRd:
  ret


limpaPrintPressioneGreen:  
  mov ah, 2      ;set o posicionamento do cursor
  mov bh, 0      ;página inicial ("estado inicial")
  mov dh, 10     ;linha
  mov dl, 15     ;coluna
  int 10h        ;Chama a interrupção de Vídeo

  mov si, Lp  ;para carregar 

limpaPrintPressGr:
  lodsb          ;carrega o conteudo de SI de press para AL
  cmp al, 0      ;verifica se chegou no fim da pilha
  je fimLimpaPressGr  ;se for igual chama a subrotina

  mov bx, 0    ;definição da cor (preto)
  call printaChar   ;chama a subrotina
  jmp limpaPrintPressGr  ;loop

fimLimpaPressGr:
  ret


limpaPrintEnterRed:  
  mov ah, 2  ;set o posicionamento do cursor
  mov bh, 0  ;página inicial ("estado inicial")
  mov dh, 12 ;linha
  mov dl, 15 ;coluna
  int 10h    ;interrupção de vídeo

  mov si, Le

limpaPrintEnterRd:
  lodsb          ;carrega o conteudo de SI de press para AL
  cmp al, 0      ;verifica se chegou no fim da pilha
  je fimLimpaEnterRd  ;se for igual chama a subrotina

  mov bx, 0  ;definição da cor (preto)
  call printaChar  ;chama a subrotina
  jmp limpaPrintEnterRd ;loop

fimLimpaEnterRd:
  ret


limpaPrintEnterGreen:  
  mov ah, 2  ;set o posicionamento do cursor
  mov bh, 0  ;página inicial ("estado inicial")
  mov dh, 12 ;linha 
  mov dl, 15 ;coluna
  int 10h    ;interrupção de vídeo

  mov si, Le

limpaPrintEnterGr:
  lodsb           ;carrega o conteudo de SI de press para AL
  cmp al, 0       ;verifica se chegou no fim da pilha
  je fimLimpaEnterGr   ;loop

  mov bx, 0     ;definição da cor (preto)
  call printaChar    ;chama a subrotina
  jmp limpaPrintEnterGr   ;loop

fimLimpaEnterGr:
  ret

;Ate são so as strings
gerarColunaComida:
   
    mov ah, 00 
    int 1ah    ;interrupção do clock 
    
    mov al, dl ;dl é a parte que atualiza mais rápido

    mov bx, 49 ;número de colunas da área limite

    div bl ;

    mov al, ah
    mov ah, 0
    mov bx, 5
    mul bl ;a coluna obtida esta em AX
    cmp ax, 0
    je gerarColunaComida
    ret


gerarLinhaComida:
    
    mov ah, 00
    int 1ah

    mov al, dl

    mov bl, 39
    
    div bl ;o resto da divisão fica em ah

    mov al, ah
    mov ah, 0
    mov bx, 5
    mul bl ;a linha obtida esta em AX
    cmp ax, 0
    je gerarLinhaComida
    ret


organizaComidaComSnake:
    ;compara as posições dos pixels de referẽncia na geração
    call gerarColunaComida
    push ax    ;empilhando para não perder a coluna
    call gerarLinhaComida
    mov dx, ax ;valor da linha em DX
    pop cx     ;desempilhando o valor para a coluna
    
    mov bh, cl  ;par ordenado 
    mov bl, dl  ;par ordenado

    mov si, snake

comparaFoodSnake: 
    ;compara as posições dos pixels de referẽncia
    lodsw     ;carregando word
    cmp ax, 0 ;
    je saiComparaFoodSnake
    cmp bx, ax
    je organizaComidaComSnake
    jmp comparaFoodSnake

saiComparaFoodSnake:
    ret
;acaba a geração de comida

printaFoodSnake:
    call organizaComidaComSnake
    call printaQuadradoFood
    ret


;aleatoriedade
clockControle:
    ;vai ser verificado uma vez
    push cx
    push dx

    mov ah, 00
    int 1ah

    mov bx, dx

    pop dx
    pop cx

    ret


clockVerifica:
    ;vai ser verificado várias vezes
    push cx
    push dx

    mov ah, 00
    int 1ah

    mov ax, dx

    pop dx
    pop cx

    ret

;#############   Quadrado inicial  ############


printaQuadradoPreto:
    push dx
    mov bx, dx
    add bx, 4
    push bx
    mov di, sp

organizaPixelPreto:
    push cx
    mov bx, cx
    add bx, 4
    push bx

printaPixelPreto:

    mov si, sp    

    mov ah, 0ch ;código da interrupção para printa pixel
    mov al, 0
    mov bh, 0
    int 10h

    cmp cx, [si]
    je mudarLinhaPreto

    inc cx
    jmp printaPixelPreto

mudarLinhaPreto:
    pop cx
    pop cx

    cmp dx, [di]
    je fimQuadradoPreto
        
    inc dx
    jmp organizaPixelPreto

fimQuadradoPreto:
    pop dx
    pop dx
    ret



;ta usando si e di na printaquadrado, não pode conflita com uso de stos lods


printaQuadradoMove:
    push dx
    mov bx, dx
    add bx, 4
    push bx
    mov di, sp
    

organizaPixelMove:
    push cx
    mov bx, cx
    add bx, 4
    push bx

printaPixelMove:
    mov si, sp    

    mov ah, 0ch ;código da interrupção para printa pixel
    mov al, 11 ;cor do pixel
    mov bh, 0
    int 10h

    cmp cx, [si]
    je mudaLinhaMove

    inc cx
    jmp printaPixelMove


mudaLinhaMove:
    pop cx
    pop cx

    cmp dx, [di]
    je fimQuadradoMove
        
    inc dx
    jmp organizaPixelMove


fimQuadradoMove:
    pop dx
    pop dx
    ret

;fim do movimento da cobra

printaQuadradoFood:
    push dx
    mov bx, dx
    add bx, 4
    push bx
    mov di, sp
    

organizaPixelFood:
    push cx
    mov bx, cx
    add bx, 4
    push bx

printaPixelFood:
    mov si, sp    

    mov ah, 0ch
    mov al, 13
    mov bh, 0
    int 10h

    cmp cx, [si]
    je mudaLinhaFood

    inc cx
    jmp printaPixelFood


mudaLinhaFood:
    pop cx
    pop cx

    cmp dx, [di]
    je fimQuadradoFood
        
    inc dx
    jmp organizaPixelFood


fimQuadradoFood:
    pop dx
    pop dx
    ret



;fim do pixel da comida


moveStringSnake:    

    call printaQuadradoMove  ;chama a subrotina

    push cx ;empilha para o guardar o pixel de referencia do inicial da cobra
    push dx ;empilha 

    xor ax, ax ;zera o registrador, para evitar lixo
    mov ah, cl ;realoca as coordenadas do corpo da cobra, para transformar em um par ordenado
    mov al, dl ;

    mov si, snake ;para carregar as coordenadas do corpo
    mov di, snake ;para armazenar a nova ordenadas do corpo

modificaStringSnake:
    ;altera as coordenadas dos pixels
    push ax              ;localização da cobra
    lodsw                ;carregar o valor a pontado por SI
    cmp ax, 0            ;compara para saber se está no final da cobra, só para mover
    je fimModificaString ;sai da subrotina
    mov bx, ax           ;
    pop ax               ;desempilha
    stosw                ;
    mov ax, bx           ;
    jmp modificaStringSnake ;loop 

fimModificaString:
    pop ax

    mov cl, ah
    mov dl, al

    call printaQuadradoPreto

    pop dx
    pop cx
    ret

;fim da função que move a cobra

    
ehFood:
    ;adiciona uma posição a string snake
    mov cx, ax
    mov dx, bx

moveStringSnakeEat:    

    call printaQuadradoMove

    push cx ;empilhei pra não perder a cabeça que ira para o jogo rodando
    push dx

    xor ax, ax
    mov ah, cl
    mov al, dl

    mov si, snake
    mov di, snake

modificaStringSnakeEat:
    push ax
    lodsw
    cmp ax, 0
    je fimModificaStringEat
    mov bx, ax
    pop ax
    stosw
    mov ax, bx
    jmp modificaStringSnakeEat

fimModificaStringEat:
    pop ax
    stosw

    mov ax, 0x0000
    stosw

    call alterarScore

    pop dx
    pop cx
    
    ret


;fim da função de aumento da cobra


verificaColisoes:
    cmp cx, 0
    je reiniciar
    cmp cx, 245
    je reiniciar
    cmp dx, 0
    je reiniciar
    cmp dx, 195
    je reiniciar

    mov si, snake

    mov bh, cl
    mov bl, dl

kbcaNoCorpo:
    lodsw
    cmp ax, 0
    je naoBateu
    cmp ax, bx
    je reiniciar
    jmp kbcaNoCorpo
    

naoBateu:
    ret

reiniciar:
    call capituraVm
    call start

; fim da função que verifica colisões da cobra
capituraVm:

    call printPressioneVermelho
    call printEnterVermelho
    call clockControle
    add bx, 3

esperaVermelho:
    ;alterar a cor da string end game
    call clockVerifica
    cmp ax, bx
    jg capituraVd

    mov ah, 01
    int 16h

    jz esperaVermelho

    mov ah, 00
    int 16h

    cmp al, 13
    je sairEnter

    jmp esperaVermelho



capituraVd:

    call printPressioneVerde
    call printEnterVerde
    call clockControle
    add bx, 3

esperaVerde:
    call clockVerifica
    cmp ax, bx
    jg capituraVm

    mov ah, 01
    int 16h

    jz esperaVerde

    mov ah, 00
    int 16h

    cmp al, 13
    je sairEnter

    jmp esperaVerde

capturaRd:

    call printPressioneRed
    call printEnterRed
    call clockControle
    add bx, 3

esperaRed:
    ;alterar a cor da string end game
    call clockVerifica
    cmp ax, bx
    jg capturaGr

    mov ah, 01
    int 16h

    jz esperaRed

    mov ah, 00
    int 16h

    cmp al, 13
    je sairEnter

    jmp esperaRed



capturaGr:

    call printPressioneGreen
    call printEnterGreen
    call clockControle
    add bx, 3

esperaGreen:
    call clockVerifica
    cmp ax, bx
    jg capturaRd

    mov ah, 01
    int 16h

    jz esperaGreen

    mov ah, 00
    int 16h

    cmp al, 13
    je sairEnter

    jmp esperaGreen

sairEnter:

    mov ah, 0x02
    mov bh, 0
    mov dh, 5
    mov dl, 34
    int 10h

    mov si, vazia

printVaziaScore:

    lodsb
    cmp al, 0
    je setPosiVaziaTimer

    mov bx, 0x000c
    call printaChar
    jmp printVaziaScore

setPosiVaziaTimer:

    mov ah, 0x02
    mov bh, 0
    mov dh, 12
    mov dl, 34
    int 10h

    mov si, vazia

printVaziaTimer:

    lodsb
    cmp al, 0
    je setPosiVaziaPress

    mov bx, 0x000c

    call printaChar

    jmp printVaziaTimer


setPosiVaziaPress:

    mov ah, 2
    mov bh, 0
    mov dh, 20
    mov dl, 33
    int 10h

    mov si, vazia

printVaziaPress:

    lodsb
    cmp al, 0
    je setPosiVaziaEnter

    mov bx, 0x000c
    call printaChar
    jmp printVaziaPress


setPosiVaziaEnter:

    mov ah, 2
    mov bh, 0
    mov dh, 22
    mov dl, 33
    int 10h

    mov si, vazia

printVaziaEnter:

    lodsb
    cmp al, 0
    je limparOutros

    mov bx, 0x000c
    call printaChar
    jmp printVaziaEnter



;printScorePontuacao:

 limparOutros:

    call limparTimer    ;chamada de função
    call limparPontos   ;chamada de função
    call alocaCobra     ;chamada de função

limparTimer:

    mov al, 0            ;compara al com 0 
    mov [timerzinho], al ;inicia timerzinho com 0 

limparPontos:

    mov al, 0           ;compara al com 0 
    mov [pontos], al    ;inicia a contagem de ponto com 0 

alocaCobra:

    ;limpeza de registrador
    mov si, snake       ;move a cobra para si 
    mov cx, 0           ;coluna 
    mov dx, 0           ;linha

;Até aqui

apagaSnake:

    lodsw
    cmp ax, 0
    je termino
    mov cl, ah
    mov dl, al
    mov ax, si
    push ax
    call printaQuadradoPreto
    pop ax
    mov si, ax
    jmp apagaSnake

termino:
    
    mov bx, 0
    
    ret

alterarScore:

    mov ah, 0x02
    mov bh, 0
    mov dh, 5
    mov dl, 34
    int 10h

    mov ah, 0
    mov al, [pontos]
    inc al
    mov [pontos], al

    mov ah, 0
    mov bx, 10
    push bx
    mov dx, 0

empilharPontuacao:
    cmp al, 0
    je desempilhar
    div bl
    mov dl, ah
    push dx
    mov ah, 0
    jmp empilharPontuacao

desempilhar:
    pop ax
    cmp al, 10
    je acabou
    
    add al, 48

    mov ah, 0xe
    mov bx, 14
    int 10h

    jmp desempilhar

acabou:
    ret


tempoPartida:

    mov ah, 0x02
    mov bh, 0
    mov dh, 12
    mov dl, 34
    int 10h         ;seta a posição do cursor

    mov ah, 2
    int 1ah

    cmp [tempinho], dh
    je fimTimer

    mov [tempinho], dh
    mov al, [timerzinho]    ;valor inicial do clock do jogo
    inc al
    mov [timerzinho], al

    ;fazer o jogo encerrar com 30s
    mov bl, 31             ;setando o tempo limite para o enceramento do jogo para 30s
    cmp [timerzinho], bl   ;comparando o valor do registrador al com 30s (bl) 
    je estouraTempo        ;caso timerzinho seja igual a 30s o jogo é encerrado

    mov ah, 0              ;zerando ah para fazer a divisão
    mov bx, 10
    push bx
    mov dx, 0

empilharTimer:

    cmp al, 0
    je desempilharTimer
    div bl
    mov dl, ah
    push dx
    mov ah, 0
    jmp empilharTimer


desempilharTimer:

    pop ax
    cmp al, 10
    je fimTimer
    
    add al, 48

    mov ah, 0xe
    mov bx, 14
    int 10h

    jmp desempilharTimer

fimTimer:
    ret

estouraTempo:
    
    call alocaCobra
    call capituraVm
    call start

;###############################################################
;###############################################################


start:
    xor ax, ax
    mov ds, ax
    mov es, ax

    ;Setando modo de vídeo
    mov ah, 00
    mov al, 0dh
    int 10h

    call menuI

menuI:
    call printMenu
    mov ah, 00
    int 16h
    call capturaRd

    cmp al, 13
    je chamaMenu

chamaMenu:
    ;##########   GERAR CAMPO   #############
    call limpaMenu
    call limpaPrintPressioneRed
    call limpaPrintEnterRed
    call limpaPrintPressioneGreen
    call limpaPrintEnterGreen

    mov cx, 0  ;249
    mov dx, 0  ;4    

;posicionamento do superior do pixel
pixelSuperior:

    mov ah, 0ch
    mov al, 4
    mov bh, 0
    int 10h

    cmp cx, 249
    je bordaSuperior

    inc cx
    jmp pixelSuperior

bordaSuperior:

    cmp dx, 4
    je organizarEsquerda

    inc dx
    mov cx, 0
    jmp pixelSuperior

;fim do posicionamento superior do pixel

;esquerda
organizarEsquerda:
    mov cx, 0  ;4
    mov dx, 5  ;199

pixelEsquerda:
    mov ah, 0ch
    mov al, 4
    mov bh, 0
    int 10h

    cmp cx, 4
    je bordaEsquerda

    inc cx
    jmp pixelEsquerda
    
bordaEsquerda:

    cmp dx, 199
    je organizarDireita

    inc dx
    mov cx, 0
    jmp pixelEsquerda

;fim da função do posicionamento a esquerda

;Direita
organizarDireita:

    mov cx, 245 ;249
    mov dx, 5 ;199

pixelDireita:

    mov ah, 0ch
    mov al, 4
    mov bh, 0
    int 10h

    cmp cx, 249
    je bordaDireita

    inc cx
    jmp pixelDireita
    
bordaDireita:

    cmp dx, 199
    je organizarInferior

    inc dx
    mov cx, 245
    jmp pixelDireita


;fim da função do posicionamento a esquerda

;posicionamento inferior do pixel
organizarInferior:

    mov cx, 5    ;249
    mov dx, 195  ;199

pixelInferior:

    mov ah, 0ch
    mov al, 4
    mov bh, 0
    int 10h
    
    cmp cx, 249
    je bordaInferior

    inc cx
    jmp pixelInferior

bordaInferior:

    cmp dx, 199
    je sair

    inc dx
    mov cx, 5
    jmp pixelInferior


;fim do posicionamento inferior do pixel

sair:

    call printScore
    call printTempo

    ;Setando a coordenada

    mov di, snake

    mov ah, 30
    mov al, 100
    
    stosw

    mov ah, 25
    mov al, 100
    
    stosw

    mov ah, 20
    mov al, 100
    
    stosw

    xor ax, ax
    stosw

    call printaFoodSnake ; printa a comida

    push cx
    push dx

    mov cx, 35
    mov dx, 100


direita:

    add cx, 5 ;coluna

    call verificaColisoes

    cmp bx, 0
    je restart

    ;comida
    pop bx ;linha comida
    pop ax ;coluna comida

    ;tem que rolar as comparações de colisão aqui

    cmp cx, ax
    jne naoEhComidaDireita
    cmp dx, bx
    jne naoEhComidaDireita

    call ehFood
    push cx ;empilha nova coluna kbça da cobra
    push dx ;empilha nova linha kbça da cobra

    ;resetar o tempo após comer (não funciona!!)
    mov al, 0
    mov [timerzinho], al
    call tempoPartida


    ;bom lugar para alterar o placar
    call printaFoodSnake
    mov ax, cx ;passando nova coluna da comida para ax
    mov bx, dx ;passando nova linha da comida para Bx

    pop dx 
    pop cx

    push ax
    push bx
    jmp capturaD

naoEhComidaDireita:

    push ax
    push bx

    call moveStringSnake    

capturaD:

    call clockControle

    add bx, 0x0002
    
esperaD:
    
    push ax
    push bx
    push cx
    push dx

    call tempoPartida

    pop dx
    pop cx
    pop bx
    pop ax

    call clockVerifica
    
    cmp ax, bx
    jg direita

    mov ah, 01
    int 16h

    jz esperaD

    mov ah, 00
    int 16h

    cmp al, 'w'
    je cima

    cmp al, 's'
    je baixo

    cmp al, 'd'
    je direita

    jmp esperaD


cima:

    sub dx, 5

    call verificaColisoes

    cmp bx, 0
    je restart

    pop bx
    pop ax

    cmp cx, ax
    jne naoEhComidaCima
    cmp dx, bx
    jne naoEhComidaCima

    call ehFood

    push cx
    push dx

    ; resetar o tempo após comer 
    mov ah, 0   
    mov al, 0
    mov [timerzinho], al
    call tempoPartida

    call printaFoodSnake

    mov ax, cx
    mov bx, dx
    pop dx
    pop cx
    push ax
    push bx
    jmp capturaC

naoEhComidaCima:

    push ax
    push bx

    call moveStringSnake

capturaC:  

    call clockControle
    add bx, 0x0002
    
esperaC:

    push ax
    push bx
    push cx
    push dx

    call tempoPartida

    pop dx
    pop cx
    pop bx
    pop ax

    call clockVerifica
    
    cmp ax, bx
    jg cima

    mov ah, 01
    int 16h

    jz esperaC

    mov ah, 00
    int 16h

    cmp al, 'a'
    je esquerda

    cmp al, 'd'
    je direita

    cmp al, 'w'
    je cima

    jmp esperaC


esquerda:
    
    sub cx, 5

    call verificaColisoes

    cmp bx, 0
    je restart

    pop bx
    pop ax

    cmp cx, ax
    jne naoEhComidaEsquerda
    cmp dx, bx
    jne naoEhComidaEsquerda

    call ehFood
    push cx
    push dx

    ;resetar o tempo após comer (não funciona!!)
    mov bx, 0 ; tira resto da divisao
    mov al, 0
    mov [timerzinho], al
    call tempoPartida

    call printaFoodSnake

    mov ax, cx
    mov bx, dx
    pop dx
    pop cx
    push ax
    push bx
    jmp capturaE

naoEhComidaEsquerda:
    push ax
    push bx

    call moveStringSnake

capturaE:  

    call clockControle

    add bx, 0x0002
    
esperaE:

    push ax
    push bx
    push cx
    push dx

    call tempoPartida

    pop dx
    pop cx
    pop bx
    pop ax

    call clockVerifica
    
    cmp ax, bx
    jg esquerda

    mov ah, 01
    int 16h

    jz esperaE

    mov ah, 00
    int 16h

    cmp al, 'w'
    je cima

    cmp al, 's'
    je baixo

    cmp al, 'a'
    je esquerda

    jmp esperaE


baixo:

    add dx, 5

    call verificaColisoes

    cmp bx, 0
    je restart

    pop bx
    pop ax

    cmp cx, ax
    jne naoEhComidaBaixo
    cmp dx, bx
    jne naoEhComidaBaixo

    call ehFood

    push cx
    push dx

    ;resetar o tempo após comer (não funciona!!)
    mov bx, 0 ; tira resto da divisao
    mov al, 0
    mov [timerzinho], al
    call tempoPartida

    call printaFoodSnake

    mov ax, cx
    mov bx, dx
    pop dx
    pop cx
    push ax
    push bx
    jmp capturaB


naoEhComidaBaixo:
    push ax
    push bx

    call moveStringSnake

capturaB:  

    call clockControle

    add bx, 0x0002
    
esperaB:

    push ax
    push bx
    push cx
    push dx

    call tempoPartida

    pop dx
    pop cx
    pop bx
    pop ax

    call clockVerifica
    
    cmp ax, bx
    jg baixo

    mov ah, 01
    int 16h

    jz esperaB

    mov ah, 00
    int 16h
    
    cmp al, 'a'
    je esquerda

    cmp al, 'd'
    je direita

    cmp al, 's'
    je baixo

    jmp esperaB

restart:
    pop dx
    pop cx

    call printaQuadradoPreto

    jmp sair