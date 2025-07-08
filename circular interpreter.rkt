#lang plai
#|
<expr> ::= <num>
            | {+ <expr> <expr>}
            | {- <expr> <expr>}
            | {if0 <expr> <expr> <expr>}
            | <symbol-id>
            | {with {<symbol-id> <expr>} <expr>}
            | {fun {sym-arg} <expr>}
            | {<expr> <expr>}
|#
(define-type Env
  [empty-env]
  [extended-env (id symbol?) (val Value?) (env Env?)])
(define-type Value
  [numV (n number?)]
  [closureV (id symbol?) (body Exp?) (env Env?)])
(define-type Exp
    [num  (n number?)]
    [plus (left Exp?) (right Exp?)]
    [minus (left Exp?) (right Exp?)]
    [if0 (cond Exp?) (etrue Exp?) (efalse Exp?)]
    [id  (s symbol?)]
    [mybegin (expl list?)]
    [fun (sym-arg symbol?) (body Exp?)]
    [call (cls-exp Exp?) (arg-expr Exp?)])

(define (env-lookup x env)
  (match env
    [(empty-env) (error 'env-lookup "not found: ~a" x)]
    [(extended-env id val sub-env)
     (if (symbol=? id x)
         val
         (env-lookup x sub-env))]))





(define (parse s-expr)
  (match s-expr
    [(? number?) (num s-expr)]
    [(? symbol?) (id s-expr)]
    [(list '+ l r) (plus (parse l) (parse r))]
    [(list '- l r) (minus (parse l) (parse r))]
    [(list 'begin expl) (mybegin (map parse expl))]
    [(list 'if0 c t f) (if0 (parse c) (parse t) (parse f))]
    [(list 'with (list sym se) be)
     (call (fun sym (parse be))
           (parse se))]
    [(list 'fun (list sym-arg) be)
                (fun sym-arg (parse be))]
    [(list cls-exp arg-exp)
                (call (parse cls-exp) (parse arg-exp))]
    [else (error 'parse "syntax error")]))


(define (aux expl)
    (if (empty? expl)
        empty
        (if (empty? (cdr expl))
            (car expl)
            (aux (cdr expl))))
)
;; interp (Exp x Env) --> Scheme Value
(define (interp expr env)
  (match expr
    [(num n) n]
    [(id s)  (env-lookup s env)]
    [(plus l r) (+ (interp l env) (interp r env))]
    [(minus l r) (- (interp l env) (interp r env))]
    [(mybegin expl) (interp (aux expl) env)]
    [(if0 c t f) (if (zero? (interp c env)) (interp t env) (interp f env))]
    ;; Aqui en lugar de crear un closureV, creamos un lambda de scheme
    [(fun sym-arg fun-body)
                            (lambda (arg-val)
                              (interp fun-body
                                      (extended-env sym-arg arg-val env)))]
    ;; Aqui la llamada a función, la parte izquierda devuelve un labmda de scheme
    ;; Entonces tenemos que ejecutarlo directamente
    [(call cls-exp arg-exp) ((interp arg-exp env) (interp cls-exp env))]))

(define (run prog)
    (interp (parse prog) (empty-env)))

(run '{+ 1 2})
(parse '{begin {{+ 1 2} {+ 5 6}}})
(run '{begin {{+ 1 2} {+ 5 6}}})