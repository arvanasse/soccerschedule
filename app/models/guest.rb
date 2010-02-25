class Guest
  def admin?
    false
  end

  def following?( team_id )
    false
  end

  def team_ids
    nil
  end
end
