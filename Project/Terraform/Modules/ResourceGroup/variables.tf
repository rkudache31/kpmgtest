variable "resource_group" {
  type = map(object({
    name     = string
    location = string
  }))
}

variable "tags" {
  type = map(string)
  description = "Tags for the resources"
}