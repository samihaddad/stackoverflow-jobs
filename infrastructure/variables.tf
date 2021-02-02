variable "project_id" {
  description = "GCP project ID"
  type        = string

}
variable "credentials_path" {
  description = "GCP JSON credentials file path"
  type        = string
}

variable "machine_name" {
  description = "GCP VM instance machine name"
  type        = string
}

variable "machine_type" {
  description = "GCP VM instance machine type"
  type        = string
  default     = "f1-micro"
}
