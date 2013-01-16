module AdminsHelper
  
  def status(arg)
    arg == false ? "Active" : "Suspended"
  end
  
end