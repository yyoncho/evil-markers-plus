;;; evil-markers+.el --- Evil Markers extension      -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Ivan Yonchovski

;; Author: Ivan Yonchovski <yyoncho@gmail.com>
;; Keywords:

;; Version: 0.0.1
;; Package-Requires: ((evil "1.0") (emacs "25.1"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Provides `evil-markers+-set-local-marker' which will set global marker which
;; postion will be updated once you change the buffer so when you go to it you
;; will be at the last position in that buffer.

;;; Code:

(require 'evil)

(defvar evil-markers+--current-buffer nil)
(defvar evil-markers+--marker->buffer nil)
(defvar-local evil-markers+--local-marker nil)

(defun evil-markers+--post-command ()
  (unless (or (minibufferp)
              (eq evil-markers+--current-buffer (current-buffer)))
    (when (buffer-live-p evil-markers+--current-buffer)
      (with-current-buffer evil-markers+--current-buffer
        (evil-set-marker ?Z)
        (when evil-markers+--local-marker
          (evil-set-marker evil-markers+--local-marker))))
    (setq evil-markers+--current-buffer (current-buffer))))

(defun evil-markers+-set-local-marker (char)
  "Set local marker CHAR.
The marker position will be updated when you change the buffer."
  (interactive (list (read-char)))
  (setq evil-markers+--local-marker (string-to-char (upcase (char-to-string char))))
  (evil-set-marker evil-markers+--local-marker))

;;;###autoload
(define-minor-mode evil-markers+-mode
  "Toggle `evil-markers+-mode'."
  :global t
  (cond
   (evil-markers+-mode
    (setq evil-markers+--current-buffer (current-buffer))
    (add-hook 'post-command-hook #'evil-markers+--post-command ))
   (evil-markers+-mode
    (setq evil-markers+--current-buffer nil)
    (remove-hook 'post-command-hook #'evil-markers+--post-command ))))

(provide 'evil-markers+)
;;; evil-markers+.el ends here
