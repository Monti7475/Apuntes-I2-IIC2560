#lang racket

(define-syntax new-object
  (syntax-rules (field method)
    [(new-object ([field fname fval] ...)
                 ([method mname (mparams ...) mbody ...] ...))
     (letrec
         ([self 
           (let ([fname fval] ...) 
             (λ (msg . args)
               (let ([methods
                      (list (cons 'mname (λ (mparams ...) mbody ...)) ...)])
                 (let ([found (assoc msg methods)])
                   (if found
                       (apply (cdr found) (cons self args))
                       (error "mensaje no entendido:" msg))))))]
          )
          self
       )]))

(define-syntax →
  (syntax-rules ()
    [(→ objeto metodo arg ...)  
     (objeto 'metodo arg ...)]))


(define counter-factory
  (new-object
   ([field default-count 0]
    [field default-step 1])
   ([method df-count! (self v) (set! default-count v)]
    [method df-step! (self v) (set! default-step v)]
    [method make (self )
     (new-object
      ([field count default-count]
       [field step  default-step])
      ([method inc (self) (set! count (+ count step)) count]
       [method dec (self) (set! count (- count step)) count]
       [method reset (self) (set! count 0)]
       [method step! (self v) (set! step v)]
       [method inc-by! (self v) (→ self step! v) (→ self inc)]))])))
 

(define c1 (→ counter-factory make))
(→ c1 inc)


(→ counter-factory df-count! 10)
(→ counter-factory df-step! 5)
(→ c1 inc)

(define c2 (→ counter-factory make))
(→ c2 inc)
(→ c1 inc)
(→ c2 inc)

