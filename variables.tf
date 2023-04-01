variable gcp_project {
  type = string
}

variable region {
  type = string
  default = "europe-west1"
}

variable zone {
  type = string
  default = "europe-west1-a"
}


variable "gcp_service_list" {
  description ="The list of apis necessary for the project"
  type = list(string)
  default = [
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "iam.googleapis.com"
    	
  ]
}

