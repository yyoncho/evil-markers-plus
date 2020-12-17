# evil-markers+

Provides `evil-markers+-set-local-marker` which will set global marker which
postion will be updated once you change the buffer so when you go to it you
will be at the last position in that buffer.

## Usage

Clone the repo or use `quelpa`.


``` emacs-lisp
(with-eval-after-load 'evil
   (evil-markers+-mode 1)
   (define-key evil-normal-state-map "gm" 'evil-markers+-set-local-marker))
```
