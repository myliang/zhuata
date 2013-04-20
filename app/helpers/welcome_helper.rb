module WelcomeHelper
  def tag_type_name(tag_type)
    t("models.#{tag_type.to_s[0...-3].underscore}")
  end

  def controller_name_by_type(tag_type)
    tag_type.to_s[0...-3].tableize
  end
end
