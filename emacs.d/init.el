(setq jdb-emacs-init-file load-file-name)
(setq jdb-emacs-config-dir
      (file-name-directory jdb-emacs-init-file))
 
;; Set up 'custom' system
(setq custom-file (expand-file-name "emacs-customizations.el" jdb-emacs-config-dir))
(load custom-file)

(setq user-emacs-directory jdb-emacs-config-dir)
 
(setq backup-directory-alist
      (list (cons "." (expand-file-name "backup" user-emacs-directory))))
