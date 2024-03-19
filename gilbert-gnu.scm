;; -*- mode: scheme; -*-
;; This is an operating system configuration for WSL 2 Environments

(use-modules
 (gnu)
 (gnu system images wsl2)
 (gnu system nss)
 (gnu packages vim)
 (gnu packages version-control)
 )

(use-package-modules bootloaders certs emacs emacs-xyz xorg)

(operating-system
 (inherit wsl-os)
 (timezone "Asia/Hong_Kong")
 (locale "en_US.utf8")

 ;; Assume the target root file system is labelled "my-root",
 ;; and the EFI System Partition has UUID 1234-ABCD.
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

 ;; (users (cons (user-account
 ;;               (name "Gilbert")
 ;;               (comment "Hacker and Programmer")
 ;;               (group "users")
 ;;               (supplementary-groups '("wheel" "netdev"
 ;;                                       "audio" "video")))
 ;;              %base-user-accounts))

 ;; Add a bunch of window managers; we can choose one at
 ;; the log-in screen with F1.
 (packages (append (list
                    ;; window managers
                    vim
                    emacs emacs-exwm emacs-desktop-environment
                    git
                    ;; terminal emulator
                    ;; xterm
                    ;; for HTTPS access
                    nss-certs)
                   %base-packages))
 (services
  (cons* (operating-system-user-services wsl-os))
  )

 ;; Allow resolution of '.local' host names with mDNS.
 (name-service-switch %mdns-host-lookup-nss))
