;;  This is the configuration used on the Lenovo T440p as at Friday 16 September 2022
  
  ;; NOTE: init.el is now generated from Emacs.org.  Please edit that file
  ;;       in Emacs and init.el will be generated automatically!

  ;; You will most likely need to adjust this font size for your system!
  (defvar efs/default-font-size 377)
  (defvar efs/default-variable-font-size 377)

  ;; Make frame transparency overridable
  (defvar efs/frame-transparency '(100 . 100))

  (setq byte-compile-warnings '(not obsolete)) ;;gets rid of the "cl is deprecated" warning

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

  ;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe))
  (auto-package-update-at-time "09:00")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(calendar-date-style 'european)
 '(connection-local-criteria-alist
   '(((:application eshell)
      eshell-connection-default-profile)) t)
 '(connection-local-profile-alist
   '((eshell-connection-default-profile
      (eshell-path-env-list))) t)
 '(custom-safe-themes
   '("eb7cd622a0916358a6ef6305e661c6abfad4decb4a7c12e73d6df871b8a195f8" "e01db763cd9daa56f75df8ebd057f84017ae8b5f351ec90c96c928ad50f3eb25" "28eb6d962d45df4b2cf8d861a4b5610e5dece44972e61d0604c44c4aad1e8a9d" "31f1723fb10ec4b4d2d79b65bcad0a19e03270fe290a3fc4b95886f18e79ac2f" "6c98bc9f39e8f8fd6da5b9c74a624cbb3782b4be8abae8fd84cbc43053d7c175" default))
 '(display-buffer-base-action
   '((display-buffer-reuse-window display-buffer-same-window)
     (reusable-frames . t)))
 '(even-window-sizes nil)
 '(org-agenda-compact-blocks t)
 '(org-agenda-format-date "%a %d %b")
 '(org-agenda-span 'fortnight)
 '(org-agenda-start-on-weekday nil)
 '(org-agenda-time-grid
   '(nil
     (800 1000 1200 1400 1600 1800 2000)
     "......" "----------------"))
 '(org-latex-compiler "pdflatex" t)
 '(package-selected-packages
   '(elgrep modus-themes sudo-edit exec-path-from-shell vterm cider clojure-mode better-defaults htmlize elpher w3m org-noter-pdftools org-pdftools org-noter pdf-tools ox-reveal consult marginalia orderless vertico firecode-theme racket-mode geiser-racket l paredit geiser-guile transpose-frame green-screen-theme green-is-the-new-black-theme plantuml-mode elfeed-goodies yasnippet-snippets yasnippet lsp-jedi pomodoro magit projectile company lsp-mode counsel ivy all-the-icons peep-dired which-key visual-fill-column use-package typescript-mode rainbow-delimiters pyvenv python-mode perspective org-roam org-bullets olivetti no-littering lsp-ui lsp-treemacs lsp-ivy ivy-rich ivy-prescient helpful forge eterm-256color eshell-git-prompt emms-state elfeed doom-themes doom-modeline dired-single dired-open dash-functional counsel-projectile company-box command-log-mode auto-package-update all-the-icons-dired))
 '(peep-dired-ignored-extensions '("mkv" "iso" "mp4" "jpg" "jpeg" "png" "bmp"))
 '(persp-state-default-file "~/Dropbox/emacs/config/perspective-state")
 '(warning-suppress-types '((comp))))

;; NOTE: If you want to move everything out of the ~/.emacs.d folder
;; reliably, set `user-emacs-directory` before loading no-littering!
;(setq user-emacs-directory "~/.cache/emacs")

(use-package no-littering)

;; no-littering doesn't set this by default so we must place
;; auto save files in the same path as it uses for sessions
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(setq inhibit-startup-message t)

  (scroll-bar-mode -1)        ; Disable visible scrollbar
  (tool-bar-mode -1)          ; Disable the toolbar
  (tooltip-mode -1)           ; Disable tooltips
  (set-fringe-mode 10)        ; Give some breathing room
  (menu-bar-mode -1)            ; Disable the menu bar

  ;; Set up the visible bell
  (setq visible-bell t)

  (column-number-mode)
;;  (global-display-line-numbers-mode t) ;;not applicable until emacs 26 apparently

  ;; Set frame transparency
  (set-frame-parameter (selected-frame) 'alpha efs/frame-transparency)
  (add-to-list 'default-frame-alist `(alpha . ,efs/frame-transparency))
  (set-frame-parameter (selected-frame) 'fullscreen 'maximized)
  (add-to-list 'default-frame-alist '(fullscreen . maximized))
 
  ;; Disable line numbers for some modes
  (dolist (mode '(org-mode-hook
                  term-mode-hook
                  shell-mode-hook
                  treemacs-mode-hook
                  eshell-mode-hook))
    (add-hook mode (lambda () (display-line-numbers-mode 0))))

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(use-package org
  :hook (org-mode . efs/org-mode-setup)
  :config
    (setq org-ellipsis " ... ")
    (setq org-agenda-span 'month)
    (setq org-agenda-files
      '("~/Dropbox/universe/zettelkasten/20230430135243-canonical_task_list.org" "/home/tedflint/Dropbox/emacs/org/agenda.org"))

    (setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "WAITING(h)" "SOMEDAY(s)" "DAILY(e)" "WEEKLY(w)" "MONTHLY"))))

    ;; Save Org buffers after refiling!
    (advice-add 'org-refile :after 'org-save-all-org-buffers)

   (setq org-agenda-diary-file "~/.emacs.d/var/diary")
   (setq org-agenda-include-diary t)
   (setq diary-show-holidays-flag nil)

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (python . t)
    (scheme .t)
    (sqlite .t)
    (shell . t)))

(push '("conf-unix" . conf-unix) org-src-lang-modes)

;; This is needed as of Org 9.2
;; (require 'org-tempo)

 (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
 (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
 (add-to-list 'org-structure-template-alist '("py" . "src python"))
 (add-to-list 'org-structure-template-alist '("sc" . "src scheme"))

;; Automatically tangle our Emacs.org config file when we save it
(defun efs/org-babel-tangle-config ()
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name user-emacs-directory))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay .5))

;; Enable vertico
(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
 (setq vertico-scroll-margin 0)

  ;; Show more candidates
 (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  (setq vertico-cycle t)
  )

;; Optionally use the `orderless' completion style. See
;; `+orderless-dispatch' in the Consult wiki for an advanced Orderless style
;; dispatcher. Additionally enable `partial-completion' for file path
;; expansion. `partial-completion' is important for wildcard support.
;; Multiple files can be opened at once with `find-file' if you enter a
;; wildcard. You may also give the `initials' completion style a try.
(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; Enable richer annotations using the Marginalia package
(use-package marginalia
  ;; Either bind `marginalia-cycle` globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  ;; The :init configuration is always executed (Not lazy!)
  :init
  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

(use-package helpful
  :bind
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key))

;; Example configuration for Consult
(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-c k" . consult-kmacro)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ("<help> a" . consult-apropos)            ;; orig. apropos-command
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("C-s" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s m" . consult-multi-occur)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi))           ;; needed by consult-line to detect isearch

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI. You may want to also
  ;; enable `consult-preview-at-point-mode` in Embark Collect buffers.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Optionally replace `completing-read-multiple' with an enhanced version.
  (advice-add #'completing-read-multiple :override #'consult-completing-read-multiple)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme
   :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-recent-file consult--source-project-recent-file consult--source-bookmark
   :preview-key (kbd "M-."))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  ;; Optionally configure a function which returns the project root directory.
  ;; There are multiple reasonable alternatives to chose from.
  ;;;; 1. project.el (project-roots)
  (setq consult-project-root-function
        (lambda ()
          (when-let (project (project-current))
            (car (project-roots project)))))
  ;;;; 2. projectile.el (projectile-project-root)
  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-root-function #'projectile-project-root)
  ;;;; 3. vc.el (vc-root-dir)
  ;; (setq consult-project-root-function #'vc-root-dir)
  ;;;; 4. locate-dominating-file
  ;; (setq consult-project-root-function (lambda () (locate-dominating-file "." ".git")))
)

(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy)

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(use-package python-mode
    :ensure t
    :hook (python-mode . lsp-deferred)
    :custom
    ;; NOTE: Set these if Python 3 is called "python3" on your system!
    (python-shell-interpreter "python3")
    (dap-python-executable "python3")
    (dap-python-debugger 'debugpy)
    :config
    (require 'dap-python))
(setq py-python-command "python3")

(use-package pyvenv
  :config
  (pyvenv-mode 1))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/Projects/Code")
    (setq projectile-project-search-path '("~/Projects/Code")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; NOTE: Make sure to configure a GitHub token before using this package!
;; - https://magit.vc/manual/forge/Token-Creation.html#Token-Creation
;; - https://magit.vc/manual/ghub/Getting-Started.html#Getting-Started
(use-package forge)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package term
  :config
  (setq explicit-shell-file-name "bash") ;; Change this to zsh, etc
  ;;(setq explicit-zsh-args '())         ;; Use 'explicit-<shell>-args for shell-specific args

  ;; Match the default Bash shell prompt.  Update this if you have a custom prompt
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(when (eq system-type 'windows-nt)
  (setq explicit-shell-file-name "powershell.exe")
  (setq explicit-powershell.exe-args '()))

(defun efs/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell-git-prompt)

(use-package eshell
  :hook (eshell-first-time-mode . efs/configure-eshell)
  :config

  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim")))

  (eshell-git-prompt-use-theme 'powerline))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first")))

(use-package dired-single)

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-open
  :config
  ;; Doesn't work as expected!
  ;;(add-to-list 'dired-open-functions #'dired-open-xdg t)
  (setq dired-open-extensions '(("png" . "feh")
                                ("mkv" . "mpv"))))

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Dropbox/universe/zettelkasten")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n d" . org-roam-dailies-capture-today)
         ("C-c n j" . org-roam-dailies-goto-today))
  :config
  (org-roam-setup)
  (org-roam-db-autosync-mode))
  (setq org-roam-mode-sections
    (list #'org-roam-backlinks-section
          #'org-roam-reflinks-section
          #'org-roam-unlinked-references-section
          ))

   (add-to-list 'display-buffer-alist
           '("\\*org-roam\\*"
             (display-buffer-in-side-window)
             (side . right)
             (slot . 0)
             (window-width . 0.33)
             (window-parameters . ((no-other-window . t)
                                   (no-delete-other-windows . t)))))

(setq org-latex-compiler "xelatex")
(setq org-latex-pdf-process
      (list (concat "latexmk -"
                    org-latex-compiler 
                    " -recorder -synctex=1 -bibtex-cond %b")))
(setq org-latex-listings t)
(setq org-latex-default-packages-alist
      '(("" "graphicx" t)
        ("" "grffile" t)
        ("" "longtable" nil)
        ("" "wrapfig" nil)
        ("" "rotating" nil)
        ("normalem" "ulem" t)
        ("" "amsmath" t)
        ("" "textcomp" t)
        ("" "amssymb" t)
        ("" "capt-of" nil)
        ("" "hyperref" nil)))

(use-package elfeed
    :ensure t
    :commands (elfeed))
  (global-set-key (kbd "C-x w") 'elfeed)
  ;; Somewhere in your .emacs file
(setq elfeed-feeds
      '("http://nullprogram.com/feed/"
        "https://planet.emacslife.com/atom.xml"
      ("http://nullprogram.com/feed/" blog emacs)
      "http://www.50ply.com/atom.xml"  ; no autotagging
      "https://www.theguardian.com/profile/marinahyde/rss"
      "https://www.theguardian.com/profile/andrewrawnsley/rss"
      "https://www.theguardian.com/profile/johncrace/rss"
      "https://www.theguardian.com/profile/nickcohen/rss"
      "https://www.theguardian.com/profile/simonjenkins/rss"
      "https://www.theguardian.com/profile/rafaelbehr/rss"
      "https://www.theguardian.com/profile/jessicaelgot/rss"
      "https://www.theguardian.com/profile/heatherstewart/rss"
      "https://www.theguardian.com/profile/nesrinemalik/rss"
      "https://www.theguardian.com/environment/rss"
      "https://www.independent.co.uk/environment/rss"
      "https://www.theguardian.com/travel/volunteering"
      "http://www.rspb.org.uk/rss/news/all.aspx"
      "http://www.rspb.org.uk/rss/news/farming.aspx"
      "http://www.rspb.org.uk/rss/news/conservation.aspx"
      "https://dindi.garjola.net/rss.xml"
      "https://joy.pm/index.xml"
      "http://feeds.bbci.co.uk/news/rss.xml?edition=uk"
      "https://hackerspace.lifehacker.com/rss"
      "https://lifehacker.biz/tag/internet/feed/"
      "https://lifehacker.biz/tage/howto/feed/"
      "https://feeds/gawker.com/lifehacker/full"
      ))

(setq browse-url-browser-function 'browse-url-firefox) ; firefox

(use-package hydra)

(defhydra hydra-text-scale (global-map "<f2>")
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(global-set-key (kbd "M-o") 'ace-window)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(defun run-translate-script-on-region ()
  (interactive)
  (shell-command-on-region (region-beginning) (region-end)t "translate" nil nil nil t nil)
  )

(global-set-key (kbd "C-c t") 'run-translate-script-on-region)

(setq-default abbrev-mode t)
(setq abbrev-file-name                         ;; tell emacs where to read abbrev
      "~/Dropbox/emacs/config/abbrev-defs")    ;; definitions from...
(setq save-abbrevs 'silent)  ;; save abbrevs when files are saved

(setq bookmark-default-file                      ;; tell emacs where to save bookmarks
      "~/Dropbox/emacs/config/bookmarks")
(setq bookmark-save-flag 1)                      ;; save bookmarks as you go along

(message "Init file finished loading!")

(fset 'yes-or-no-p 'y-or-n-p)  ;; type y or n instead of yes or no

(bind-key "k" (lambda () (interactive) (kill-buffer (current-buffer))) ctl-x-map)

(setq org-refile-targets
      '((nil :maxlevel . 2)
        (org-agenda-files :maxlevel . 2)))

(add-to-list 'auto-mode-alist 
             '("\\.txt\\'" . org-mode))

(use-package yasnippet)
(use-package yasnippet-snippets)
(add-to-list 'load-path
                    "~/.emacs.d/plugins/yasnippet")  
(yas-reload-all)
(add-hook 'org-mode-hook #'yas-minor-mode)
(yas-global-mode 1)

(use-package plantuml-mode)
(setq org-plantuml-jar-path (expand-file-name "/home/tedflint/.plantuml/plantuml.jar"))
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))

(setq org-confirm-babel-evaluate nil)

(use-package pdf-tools)
(use-package org-noter
  :config
  ;; Your org-noter config ........
  (require 'org-noter-pdftools))

(use-package org-pdftools
  :hook (org-mode . org-pdftools-setup-link))

(use-package org-noter-pdftools
  :after org-noter
  :config
  ;; Add a function to ensure precise note is inserted
  (defun org-noter-pdftools-insert-precise-note (&optional toggle-no-questions)
    (interactive "P")
    (org-noter--with-valid-session
     (let ((org-noter-insert-note-no-questions (if toggle-no-questions
                                                   (not org-noter-insert-note-no-questions)
                                                 org-noter-insert-note-no-questions))
           (org-pdftools-use-isearch-link t)
           (org-pdftools-use-freestyle-annot t))
       (org-noter-insert-note (org-noter--get-precise-info)))))

  ;; fix https://github.com/weirdNox/org-noter/pull/93/commits/f8349ae7575e599f375de1be6be2d0d5de4e6cbf
  (defun org-noter-set-start-location (&optional arg)
    "When opening a session with this document, go to the current location.
With a prefix ARG, remove start location."
    (interactive "P")
    (org-noter--with-valid-session
     (let ((inhibit-read-only t)
           (ast (org-noter--parse-root))
           (location (org-noter--doc-approx-location (when (called-interactively-p 'any) 'interactive))))
       (with-current-buffer (org-noter--session-notes-buffer session)
         (org-with-wide-buffer
          (goto-char (org-element-property :begin ast))
          (if arg
              (org-entry-delete nil org-noter-property-note-location)
            (org-entry-put nil org-noter-property-note-location
                           (org-noter--pretty-print-location location))))))))
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)))

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key (kbd "C-c r") 'recentf-open-files)

(defun my-org-confirm-babel-evaluate (lang body)
  (not (string= lang "bash")))  ;don't ask for bash
(setq org-confirm-babel-evaluate #'my-org-confirm-babel-evaluate)

(setq org-html-head 
"<meta http-equiv='X-UA-Compatible' content='IE=edge' /><meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport' />
<style>
    html {
        touch-action: manipulation;
        -webkit-text-size-adjust: 100%;
    }
    body {
        padding: 0;
        margin: 0;
        background: #111;
        color: #bbff99;
        font-weight: normal;
        font-size: 15px;
        font-family: 'San Francisco', 'Roboto', 'Arial', sans-serif;
    }
    h2,
    h3,
    h4,
    h5,
    h6 {
        font-family: 'Trebuchet MS', Verdana, sans-serif;
        color: #ff99bb;
        padding: 0;
        margin: 20px 0 10px 0;
        font-size: 1.1em;
    }
    h2 {
        margin: 30px 0 10px 0;
        font-size: 1.2em;
    }
    a {
        color: #0000EE;
        text-decoration: none;
    }
    p {
        margin: 6px 0;
        text-align: justify;
    }
    ul,
    ol {
        margin: 0;
        text-align: justify;
    }
    ul > li > code {
        color: black;
    }
    pre {
        white-space: pre-wrap;
    }
    #content {
        width: 96%;
        max-width: 1000px;
        margin: 2% auto 6% auto;
        background: black;
        border-radius: 2px;
        border-right: 1px solid black;
        border-bottom: 2px solid black;
        padding: 0 115px 150px 115px;
        box-sizing: border-box;
    }
    #postamble {
        display: none;
    }
    h1.title {
        background-color: #100;
        color: white;
        margin: 0 -115px;
        padding: 60px 0;
        font-weight: normal;
        font-size: 2em;
        border-top-left-radius: 2px;
        border-top-right-radius: 2px;
    }
    @media (max-width: 1050px) {
        #content {
            padding: 0 70px 100px 70px;
        }
        h1.title {
            margin: 0 -70px;
        }
    }
    @media (max-width: 800px) {
        #content {
            width: 100%;
            margin-top: 0;
            margin-bottom: 0;
            padding: 0 4% 60px 4%;
        }
        h1.title {
            margin: 0 -5%;
            padding: 40px 5%;
        }
    }
    pre,
    .verse {
        box-shadow: none;
        background-color: #333;
        border: 1px solid red;
        color: violet;
        padding: 10px;
        font-family: monospace;
        overflow: auto;
        margin: 6px 0;
    }
    #table-of-contents {
        margin-bottom: 50px;
        margin-top: 50px;
    }
    #table-of-contents h2 {
        margin-bottom: 5px;
    }
    #text-table-of-contents ul {
        padding-left: 15px;
    }
    #text-table-of-contents > ul {
        padding-left: 0;
    }
    #text-table-of-contents li {
        list-style-type: none;
    }
    #text-table-of-contents a {
        color: scarlet;
        font-size: 0.95em;
        text-decoration: none;
    }
    table {
        border-color: black;
        font-size: 0.95em;
    }
    table thead {
        color: #586b82;
    }
    table tbody tr:nth-child(even) {
        background: #010;
    }
    table tbody tr:hover {
        background: black !important;
        color: white;
    }
    table .left {
        text-align: left;
    }
    table .right {
        text-align: right;
    }
    .todo {
        font-family: inherit;
        color: inherit;
    }
    .done {
        color: inherit;
    }
    .tag {
        background: initial;
    }
    .tag > span {
        background-color: seagreen;
        font-family: monospace;
        padding-left: 7px;
        padding-right: 7px;
        border-radius: 2px;
        float: right;
        margin-left: 5px;
    }
    #text-table-of-contents .tag > span {
        float: none;
        margin-left: 0;
    }
    .timestamp {
        color: #7c8ca1;
    }
    @media print {
        @page {
            margin-bottom: 3cm;
            margin-top: 3cm;
            margin-left: 2cm;
            margin-right: 2cm;
            font-size: 10px;
        }
        #content {
            border: none;
        }
    }
</style>")

(defun my-append-string-to-file (s filename)
    (with-temp-buffer
        (insert "[[")
        (insert s)
        (insert "]]\n")
        (write-region (point-min) (point-max) filename t)))

(defun capture-buffer-name ()
    (interactive)
    (my-append-string-to-file (buffer-file-name) "/home/tedflint/Dropbox/emacs/config/recent-files.txt"))

(global-set-key (kbd "C-x C-@") 'capture-buffer-name)
(add-hook 'after-save-hook 'capture-buffer-name)

(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
(autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
(setq prolog-system 'swi)
(setq auto-mode-alist (append '(("\\.pl$" . prolog-mode)
                                ("\\.m$" . mercury-mode))
                               auto-mode-alist))

(setq org-capture-templates
       '(("t" "todo" entry (file org-default-notes-file)
	  "* TODO %?\n%u\n%a\n")
	 ("d" "Diary" entry (file org-agenda-diary-file)
	  "%?\n")
	 ("i" "Idea" entry (file org-default-notes-file)
	  "* %? :IDEA: \n%t")
	 ("n" "Next Task" entry (file+headline org-default-notes-file "Tasks")
	  "** NEXT %? \nDEADLINE: %t")))
 (setq view-diary-entries-initially t
       mark-diary-entries-in-calendar t
       number-of-diary-entries 7)
 (add-hook 'diary-display-hook 'fancy-diary-display)
 (add-hook 'today-visible-calendar-hook 'calendar-mark-today)

(defun capture-idea ()
  "Capture an idea and append it to the ideas file."
  (interactive)
  (let ((idea (read-string "Enter your idea: ")))
    (with-current-buffer (find-file-noselect "/home/tedflint/Dropbox/emacs/org/ideas.txt")
      (goto-char (point-max))
      (insert (format "[%s] %s" (format-time-string "%Y-%m-%d %T") idea))
      (newline))))

(global-set-key (kbd "C-c i") 'capture-idea)

(setq calendar-week-start-day 1)

(setq org-agenda-custom-commands
      '(("n" "Agenda and all TODOs"
         ((agenda "")
          (alltodo ""))
         nil
         ("~/Dropbox/agenda.html"))))

(if (file-exists-p "/home/tedflint/.xmodmap")
    (shell-command "xmodmap /home/tedflint/.xmodmap")
       (progn
          (shell-command "cd /home/tedflint/")
          (shell-command "ln -s /home/tedflint/Dropbox/emacs/config/.xmodmap /home/tedflint/.xmodmap") 
          (shell-command "xmodmap /home/tedflint/.xmodmap")))

(setq electric-indent-mode nil)

(defvar my-packages '(better-defaults
                      projectile
                      clojure-mode
                      cider))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))

(setq desktop-path '("~/Dropbox/emacs/config/"))
(desktop-save-mode 1)

(require-theme 'modus-themes)

;; All customizations here
(setq modus-themes-bold-constructs t
      modus-themes-italic-constructs t)

;; Load the theme of choice (built-in themes are always "safe" so they
;; do not need the `no-require' argument of `load-theme').
(load-theme 'modus-vivendi)

(define-key global-map (kbd "<f5>") #'modus-themes-toggle)

(setq org-confirm-babel-evaluate nil)
(setq org-link-shell-confirm-function nil)
(setq org-link-elisp-confirm-function nil)
