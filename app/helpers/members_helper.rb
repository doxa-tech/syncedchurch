module MembersHelper

  def public?(member, field)
    !member.private.include? field
  end

end