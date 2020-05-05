variable "env_settings" {
  type = object({
    puppet_master      = string
    puppet_environment = string
    zones              = string
    region             = string
    labels             = map(string)
  })
  description =<<-EOF
  Settings of the environment in which VM is deployed, should have same settings for all projects, it consists of:
  * puppet_master
  * puppet_environment
  * region
  * zones
  * standard labels for the environment
EOF
}

variable "replicas" {
defalut = "1"
}


Variable "project_settings" {
  type = object({
    project_id      = string
    subnetwork_link = string
    service_account = object({
      email  = string
      scopes = list(string)
    })
    labels = map(string)
    dns_managed_zone = string
  })
  description =<<-EOF
    Settings of the project in which VM is deployed, should consists of:
    * project_id
    * link to the subnetwork
    * service_account
    * dns managed zone
    * labels specific for the project
EOF
}

