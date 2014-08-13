class GuestUser
  def owns?(_listing)
    false
  end

  def does_not_own?(_listing)
    false
  end

  def reserved?(_listing)
    false
  end
end
