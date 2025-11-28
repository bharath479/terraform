variable "credentials_file" {
  type = string
}

variable "project_id" {
  type        = string
  description = "GCP_PROJECT_ID"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}