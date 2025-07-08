#lang racket
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MACRO: new-object
;; Define objetos con campos y métodos (estado persistente)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-syntax new-object
  (syntax-rules (field method)
    [(new-object ([field fname fval] ...)
                 ([method mname (mparams ...) mbody ...] ...))
     (let ([fname fval] ...) ; Campos internos
       (λ (msg . args)
         (let* ([methods (list (cons 'mname (λ (mparams ...) mbody ...)) ...)]
                [fields (list (cons 'fname fname) ...)]
                [found (assoc msg methods)]
                [found2 (assoc msg fields)]
               )
           (if found
                 (apply (cdr found) args)
                 (if found2
                   (cdr found2)
                   (error "mensaje no entendido:" msg))))))]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MACRO: →
;; Azúcar sintáctico para enviar mensajes: (→ obj metodo arg ...) ≡ (obj 'metodo arg ...)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-syntax →
  (syntax-rules ()
    [(→ objeto metodo arg ...)
     (objeto 'metodo arg ...)]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ejercicio 4: Objeto `stack` (pila)
;; Campos: pila (una lista)
;; Métodos:
;; - push (valor): agrega un elemento al tope
;; - pop: elimina el elemento superior
;; - top: devuelve el elemento superior
;; - vacía?: devuelve #t si la pila está vacía
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (make-stack)
  (new-object 
    ([field stack empty])
    (
      [method push (value) (set! stack (cons value stack))]
      [method pop () (set! stack (cdr stack))]
      [method top () (car stack)]
      [method vacía? () (empty? stack)]
    )
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ejemplo de uso
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define s (make-stack))

(→ s push 10)
(→ s push 20)
(displayln (→ s top))      ; => 20
(→ s pop)
(displayln (→ s top))      ; => 10
(displayln (→ s vacía?))   ; => #f
(→ s pop)
(displayln (→ s vacía?))   ; => #t 


(→ s push 10)
(→ s push 20)
(displayln (→ s top))      ; => 20
(displayln (→ s top))      ; => 10
(→ s stack)