;; -*- mode: scheme; -*-
;; This is a bare bone operating system configuration for WSL 2 Environments

(use-modules (gnu) (gnu system images wsl2))

(operating-system
 (inherit wsl-os)
 (timezone "Asia/Hong_Kong")
 (locale "en_US.utf8")

 (users (cons* (user-account
                (name "gilbert")
                (group "users")
                (supplementary-groups '("wheel")) ; allow use of sudo
                (password (crypt "temp" "$6$abc"))
                (comment "Hacker and Programmer"))
               (user-account
                (inherit %root-account)
                (shell (wsl-boot-program "gilbert")))
               %base-user-accounts))

 (packages %base-packages)
 (services
  (cons* (operating-system-user-services wsl-os))
  ))
