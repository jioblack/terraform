provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"

}

#This is done for Amazon Linux 2. Depending on "PRODUCT" values, the classification values change
resource "aws_ssm_patch_baseline" "AL2" {
  name             = "patch-baseline-${var.os_type}"
  description      = "Patch Baseline for ${var.os_type} Operating System"
  operating_system = "${var.os_type}"


  global_filter {
    key    = "PRODUCT"
    values = ["AmazonLinux2"]
  }

  global_filter {
    key    = "CLASSIFICATION"
    values = ["Security"]
  }

  global_filter {
    key    = "MSRC_SEVERITY"
    values = ["Critical"]
  }

  approval_rule {
    approve_after_days = 7
 #   compliance_level   = "HIGH"  <- This is an optional parameter, and may not be relevant for us

    patch_filter {
      key    = "PRODUCT"
      values = ["AmazonLinux2"]
    }

    patch_filter {
      key    = "CLASSIFICATION"
      values = ["SecurityUpdates"]
    }

    patch_filter {
      key    = "MSRC_SEVERITY"
      values = ["Critical"]
    }
  }

  approval_rule {
    approve_after_days = 7
    
 patch_filter {
      key    = "PRODUCT"
      values = ["AmazonLinux2"]
   }
  }
}