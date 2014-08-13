class GuestUser
  def owns?(_listing)
    false
  end

  def reserved?(_listing)
    false
  end
end
