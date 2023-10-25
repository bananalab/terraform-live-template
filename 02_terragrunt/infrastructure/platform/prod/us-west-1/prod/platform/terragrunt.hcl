include "root" {
  path   = find_in_parent_folders()
  expose = true
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders())}/platform/_envcommon/platform.hcl"
  expose = true
}
