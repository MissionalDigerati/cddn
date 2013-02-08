module MembershipsHelper
  
  def approve_mem_button(membership)
    link_to "Approve", project_update_membership_path(membership, mem_update: "approved"), class: "btn btn-mini btn-success", method: :put
  end
  
  def deny_mem_button(membership)
    link_to "Deny", project_update_membership_path(membership, mem_update: "denied"), class: "btn btn-mini btn-danger", method: :put
  end
  
end
