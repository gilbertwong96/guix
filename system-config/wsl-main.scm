;; -*- mode: scheme; -*-
;; This is a bare bone operating system configuration for WSL 2 Environments

(use-modules
 (gnu)
 (gnu system images wsl2)
 (gnu system locale))

(operating-system
 (inherit wsl-os)
 (timezone "Asia/Hong_Kong")
 (locale "en_US.utf8")
 (locale-definitions
  (list (local-definition (source "en_US")
                          (name   "en_US.utf8"))
        (local-definition (source "zh")
                          (name   "zh_CN.utf8"))
        )
  )

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

 (packages %base-packages)
 (services
  (cons* (operating-system-user-services wsl-os))
  ))