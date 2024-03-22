;; -*- mode: scheme; -*-
;; This is a bare bone operating system configuration for WSL 2 Environments

(use-modules
 (gnu)
 (gnu system nss)
 (gnu system images wsl2)
 (gnu system locale))

(use-package-modules
 vim
 emacs
 shells
 tmux
 version-control
 commencement
 fonts
 fontutils)

(operating-system
 (inherit wsl-os)
 (timezone "Asia/Hong_Kong")
 (locale "en_US.utf8")

 (users (cons* (user-account
                (name "gilbertwong")
                (group "users")
                (supplementary-groups '("wheel")) ; allow use of sudo
                (password (crypt "temp" "$6$abc"))
                (comment "Hacker and Programmer"))
               (user-account
                (inherit %root-account)
                (shell (wsl-boot-program "gilbertwong")))
               %base-user-accounts))

 (packages (append (list
                    ;; Fonts
                    fontconfig
                    font-adobe-source-han-sans
                    font-jetbrains-mono
                    ;; Shell
                    fish
                    ;; Terminal
                    tmux
                    ;; Version Control
                    git
                    ;; ToolChain
                    gcc-toolchain
                    ;; Editor
                    vim
                    emacs
                    ) %base-packages))
 (services
  (cons* (operating-system-user-services wsl-os))
  )

 ;; Allow resolution of '.local' host names with mDNS.
 (name-service-switch %mdns-host-lookup-nss))
