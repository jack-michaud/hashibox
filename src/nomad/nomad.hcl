data_dir = "/var/nomad"

plugin "raw_exec" {
    config {
        enabled = true
    }
}

client {
    enabled = true
    chroot_env {
        "/bin"            = "/bin"
        "/etc"            = "/etc"
        "/lib"            = "/lib"
        "/lib32"          = "/lib32"
        "/lib64"          = "/lib64"
        "/run/resolvconf" = "/run/resolvconf"
        "/sbin"           = "/sbin"
        "/usr"            = "/usr"
        "/vagrant"        = "/vagrant"
    }
}

server {
    enabled = true
}
