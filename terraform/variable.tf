variable "project_id" {
  description = "Projects to build resources."
  type        = string
}

variable "credentials_path" {
  description = "Path of the authentication information file."
  type        = string
}

variable "github_user_name" {
  description = "Github user name."
  type        = string
}

variable "github_repository_name" {
  description = "Github repository name."
  type        = string
}
