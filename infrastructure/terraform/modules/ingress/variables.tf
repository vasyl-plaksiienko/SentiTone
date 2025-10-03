variable "namespace" { type = string, default = "traefik" }
variable "chart_version" { type = string, default = "27.0.0" }
variable "values" { type = any, default = {} }
