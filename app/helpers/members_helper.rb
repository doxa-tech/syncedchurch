module MembersHelper

  def public?(member, field)
    !member.private.include? field
  end

  def privatize_check_box_tag(field)
    check_box_tag "member[private][]", field, !public?(@member, field)
  end

end