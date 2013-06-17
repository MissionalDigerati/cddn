module AdminsHelper
  
  def status(arg)
    arg == false ? "Active" : "Suspended"
  end

  def return_input_or_nil(arg)
  	arg.present? ? "#{arg}" : "nil"
  end
  
end