(setq jdb-emacs-init-file load-file-name)
(setq jdb-emacs-config-dir
      (file-name-directory jdb-emacs-init-file))
 
;; Set up 'custom' system
(setq custom-file (expand-file-name "emacs-customizations.el" jdb-emacs-config-dir))
(load custom-file)
