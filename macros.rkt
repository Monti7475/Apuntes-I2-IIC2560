#lang plai
;ej when
(define-syntax when2
  (syntax-rules ()  
    [(when-cond condition body)
     (cond [condition body])]))
(when2 (< 1 0) (displayln "Esto NO debería imprimirse"))
;ej swap
(define-syntax swap-fn
    (syntax-rules ()
        [(swap a b) (let ([tmp x]) (set! x y) (set! y tmp))])
)
(define x 1)
(define y 2)
(swap-fn x y)
;(displayln x)
;(displayln y)

;ej bucles
(define-syntax do-times
  (syntax-rules ()
    [(do-times n body ...)
     (let loop ([i 0])
       (when (< i n)
         body ...
         (loop (+ i 1))))]))
(do-times 3
  (displayln "Hola"))

; ejercicio switch
; sintaxis elegida: switch expr default (v1 b1) (v2 b2) ...


(define-syntax switch
  (syntax-rules (else)
    [(switch expr [else default])
     default]
    [(switch expr [val body] rest ... )
     (if (= expr val)
        body
        (switch expr rest ...))]))
(switch 2
[1 "uno"]
[2 "dos"]
[3 "tres"]
[else "otro"])