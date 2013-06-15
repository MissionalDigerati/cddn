module MembershipsHelper
  
  def approve_mem_button(membership)
    link_to "Approve", project_update_membership_path(membership, mem_update: "approved"), method: :put
  end
  
  def deny_mem_button(membership)
    link_to "Deny", project_update_membership_path(membership, mem_update: "denied"), method: :put
  end
  
end
